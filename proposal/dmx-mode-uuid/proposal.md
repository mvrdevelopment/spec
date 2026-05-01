# Mandatory UUID for DMXMode (GDTF) and matching mandatory UUID reference in MVR

## Linked Issue

- [`issues/GDTF-Modes-no-GUID-problem.md`](../../../issues/GDTF-Modes-no-GUID-problem.md) — research note covering the problem and the schema evidence.
- TODO: cross-link the corresponding GitHub issues once filed against the GDTF and MVR spec repositories.

# Problem

A `<DMXMode>` is identified only by its `Name` string. There is no portable UUID anywhere on the mode in either the GDTF or the MVR schema.

Verified against the spec sources in this repository:

- `tools/gdtf.xsd:662-683` — `<xs:complexType name="DMXMode">` declares `Name`, `Geometry`, `Description`. No UUID-like attribute.
- `tools/gdtf.xsd:111-115` — `<xs:unique name="UniqueDMXModeName">` enforces `Name` uniqueness only within a single `<DMXModes>` collection.
- `tools/mvr.xsd:109, 160, 272, 304, 334, 363` — every `<GDTFMode>` reference is `type="xs:string"`.
- `spec/gdtf-spec.md:1804-1810` (Table 56) — DMX Mode attributes are Name / Description / Geometry. No UUID column.
- `spec/mvr-spec.md:398` (and five sibling rows) — "The name of the used DMX mode. This has to match the name of a DMXMode in the GDTF file."

Cross-file mode identity therefore reduces to `(FixtureType-GUID, mode-name-string)`. That key is brittle:

- A vendor that renames `"Standard"` → `"Std"` between GDTF revisions silently breaks every MVR that referenced the old name, even though the channel layout is unchanged.
- A vendor that reorders the modes inside `<DMXModes>` shifts every consumer that keys on position.
- An exporter that emits `<GDTFMode>26 CH</GDTFMode>` or `<GDTFMode>26ch</GDTFMode>` instead of `26CH` misses an exact match.
- An MVR built against an older GDTF revision references mode names that no longer exist in the current GDTF.

The asymmetry is the giveaway: `<FixtureType>` already carries a required portable UUID (`FixtureTypeID`, `guidtype`, `use="required"` at `tools/gdtf.xsd:126`). Modes are the only sub-FT entity that participates in cross-file references and lacks a stable identity.

# Solution

A coordinated GDTF + MVR major version bump that introduces a portable UUID on `<DMXMode>` (GDTF side) and a matching required UUID attribute on `<GDTFMode>` (MVR side). Both are `use="required"`. `Name` becomes a display label.

## Proposal 1 — GDTF: mandatory `DMXModeID` on `<DMXMode>`

### Changes to GDTF

Extend the `DMXMode` complexType (`tools/gdtf.xsd:662-683`) with a required UUID attribute, mirroring the existing `FixtureTypeID` pattern (`tools/gdtf.xsd:126`):

```xml
<xs:complexType name="DMXMode">
  <xs:sequence>
    <xs:element name="DMXChannels" type="DMXChannels"/>
    <xs:element name="Relations"   type="Relations"   minOccurs="0">...</xs:element>
    <xs:element name="FTMacros"    type="FTMacros"    minOccurs="0">...</xs:element>
  </xs:sequence>
  <xs:attribute name="Name"        type="nametype" use="required"/>
  <xs:attribute name="Geometry"    type="nametype" use="required"/>
  <xs:attribute name="Description" type="xs:string"/>
  <xs:attribute name="DMXModeID"   type="guidtype" use="required"/>   <!-- NEW, MANDATORY -->
  <xs:attribute name="RefDMXMode"  type="guidtype"/>                  <!-- NEW, optional -->
</xs:complexType>
```

- `DMXModeID` — `use="required"`. UUID stable across renames *and* across GDTF revisions of the same fixture type. Once minted by the authoring tool, it MUST NOT change. Renaming the mode (`Name` change) MUST preserve `DMXModeID`. This is the canonical mode identity.
- `RefDMXMode` — optional. Mirrors the existing `RefFT` pattern (`tools/gdtf.xsd:130`). Used only when a mode in a new revision *replaces* (split / merged into) one or more prior modes; carries the old `DMXModeID` so consumers can map old MVR references onto the new mode.

Add a new schema-level uniqueness constraint, parallel to `UniqueDMXModeName` at `tools/gdtf.xsd:111-115`:

```xml
<xs:unique name="UniqueDMXModeID">
  <xs:selector xpath="DMXMode"/>
  <xs:field xpath="@DMXModeID"/>
</xs:unique>
```

Reuses the existing `guidtype` simpleType (`tools/gdtf.xsd:951-955`) — same canonical UUID format already used by `FixtureTypeID`, `RefFT`, and MVR `uuid`.

Prose update for `spec/gdtf-spec.md` Table 56 (`spec/gdtf-spec.md:1804-1810`) — add a row:

| XML Attribute Name | Value Type | Description |
|---|---|---|
| DMXModeID | GUID | Stable UUID for the DMX mode. MUST persist across renames and across GDTF revisions of the same fixture type. **Required.** |

(And optionally a `RefDMXMode` row if the working group adopts that part of the proposal.)

### Migration / breaking-change handling

This is a hard schema break: `<DMXMode>` without `DMXModeID` is no longer schema-valid against the new version. Recommended migration:

1. Land the change under a major version bump (working group's call, e.g. GDTF 2.0).
2. v1.x files that lack `DMXModeID` remain valid against their own schema version. v2.x validators reject them until upgraded.
3. A producer reading a v1.x GDTF and emitting v2.x mints a fresh UUID per existing `<DMXMode>` and persists it on subsequent revisions of the same fixture type. UUIDs are not regenerated on every export.
4. The pre-2.0 ecosystem continues to resolve modes by `(FT-GUID, Name)` as today.

### Changes MVR

(N/A for this proposal — see Proposal 2.)

## Proposal 2 — MVR: mandatory `dmxModeID` on `<GDTFMode>`

### Changes to GDTF

(N/A for this proposal — see Proposal 1.)

### Changes MVR

Six call sites in `tools/mvr.xsd` reference `<xs:element name="GDTFMode" type="xs:string"/>`:

- `tools/mvr.xsd:109` (`SceneObject`)
- `tools/mvr.xsd:160` (`Fixture`)
- `tools/mvr.xsd:272` (`FocusPoint`)
- `tools/mvr.xsd:304` (`Truss`)
- `tools/mvr.xsd:334` (`VideoScreen`)
- `tools/mvr.xsd:363` (`Projector`)

Promote `GDTFMode` from a simple string to a complexType that keeps the name as element body and adds a **required** UUID attribute pointing at the GDTF-side `DMXModeID`:

```xml
<xs:complexType name="GDTFModeRef" mixed="true">
  <xs:simpleContent>
    <xs:extension base="xs:string">
      <xs:attribute name="dmxModeID" type="guidtype" use="required"/>
    </xs:extension>
  </xs:simpleContent>
</xs:complexType>
```

Replace each of the six occurrences with:

```xml
<xs:element name="GDTFMode" type="GDTFModeRef" minOccurs="0"/>
```

Authoring example:

```xml
<Fixture name="LED Par 64" uuid="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6">
  ...
  <GDTFSpec>VendorX@Pro 26CH</GDTFSpec>
  <GDTFMode dmxModeID="9A3D6BAE-2C44-4F1B-9D89-2D1A3C0F9111">26CH</GDTFMode>
  ...
</Fixture>
```

Prose update for `spec/mvr-spec.md` (the six `GDTFMode` rows at lines 398, 485, 621, 665, 706, 766) — replace the description with:

> Reference to the DMX mode used inside the GDTF file named by `GDTFSpec`. The `dmxModeID` attribute (UUID) is the canonical match against `<DMXMode DMXModeID="...">`. The element body carries the human-readable mode name for display only and MUST NOT be used for matching. Mandatory when `GDTFSpec` has been defined.

Resolution rule (consumer side):

1. Locate the matched fixture type via `<GDTFSpec>` ↔ `FixtureTypeID`.
2. Look up the DMX mode by `dmxModeID` against `<DMXMode DMXModeID="...">` inside that FT. UUID match wins.
3. If the UUID is unknown to the FT (e.g. the mode was removed in a newer GDTF revision), the reference is unresolved — consumer surfaces an error and may offer the operator a manual remap to a current mode.
4. The element body (mode name) is informational. Consumers MUST NOT use it for matching once the schema is at the new version.

### Alternative considered (not recommended)

A sibling element `<GDTFModeID>guidtype</GDTFModeID>` was considered. Rejected because it splits a single logical reference across two elements and complicates the schema for all six call sites. The `simpleContent` extension keeps the existing element shape — consumers that ignore the attribute see the same string body they always did, and consumers that read the attribute get the canonical match key with zero parsing complexity.

### Migration / breaking-change handling

Same version-bump strategy as Proposal 1: land under a coordinated MVR major. Pre-bump MVR files (no `dmxModeID`) remain valid against their own schema version and resolve by Name. A producer reading an old MVR and emitting a new one looks up each `<GDTFMode>` by Name in the referenced GDTF and writes the matching `DMXModeID`. If the GDTF itself is also being migrated to the new version (Proposal 1), the producer mints UUIDs there at the same time and threads them into the MVR.

# Why this MUST be mandatory — the patching-tool perspective

Patching tools (any tool that reconciles a console's existing patch against an updated MVR or against a swapped fixture type) MUST identify modes by UUID, not by `Name` string and not by the position of `<DMXMode>` entries inside `<DMXModes>`.

Why this matters at the tool level:

- **Mode renames break name-keyed reconciliation.** A vendor renaming `"Standard"` → `"Std"` between GDTF revisions makes a name-keyed tool see two unrelated modes; it then treats the revised MVR as a mode change for every fixture using that mode and demands an operator decision per fixture. With UUID identity, the tool sees the same mode and updates only what actually changed (channel layout, footprint).
- **Mode reordering breaks index-keyed reconciliation.** Some workflows track modes by their position in `<DMXModes>` (1st, 2nd, 3rd…) or by an integer mode index surfaced in console UIs. Reordering the GDTF's modes — or inserting a new mode at the top — silently shifts every reference. UUIDs are positionally invariant.
- **Fixture-swap and MVR-update flows depend on stable mode identity.** When an operator swaps a fixture type or imports an updated MVR for an existing show, the patching tool has to answer "is the mode this fixture used to be on still here?" Name and index are both unreliable signals; UUID is the only signal that survives both renames and reorders.
- **Without mode UUIDs, fixture-swap and patch-update flows degrade to operator-driven manual remap.** The user has to look at every fixture whose mode reference no longer resolves cleanly and decide whether the rename / reorder was intentional or a true mode change. With UUIDs, that ambiguity disappears and only genuine mode changes (different `DMXModeID`) require operator attention.

This is the operational justification for `use="required"` rather than optional. Optional UUIDs would let producers keep emitting name-only references, which leaves patching tools stuck in the current ambiguity for any file that does not opt in. Mandatory UUIDs are what make patch-update a reliable round-trip — and what let MVR fulfil its promise as a portable interchange format for shows that move between tools, vendors, and venues.

# Adoption summary

- The schema break lands in a coordinated GDTF + MVR major bump. Both sides flip to `use="required"` together.
- Producers (consoles, plot tools, exporters) MUST emit `DMXModeID` on every `<DMXMode>` and `dmxModeID` on every `<GDTFMode>` once they target the new schema version.
- For pre-bump files, producers performing a v1 → v2 migration mint a UUID per existing mode and persist it on subsequent revisions of the same fixture type. UUIDs are not regenerated on every export.
- Consumers targeting the new schema match modes solely by UUID; `Name` becomes a display-only label.
- An interim period where consumers still read v1 files using `(FT-GUID, Name)` is expected; this proposal does not deprecate that legacy path inside its own version range.
