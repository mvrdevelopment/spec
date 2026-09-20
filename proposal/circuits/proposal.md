# Power circuits on Fixture, VideoScreen and Projector

## Linked Issue

- TODO: cross-link the GitHub issue once filed against the MVR spec repository.

# Problem

MVR carries the logical *control* patch of a device (`FixtureID`, `UnitNumber`, `CustomId`, `Addresses`, `Protocols`) but nothing about its *power* patch. There is no field that says which circuit a device is plugged into.

In practice every production department already works with a circuit label per device:

- Lighting planning tools (e.g. Vectorworks Spotlight: *Circuit Name* + *Circuit Number*) store it on every lighting device and print it on the plot and on tape.
- Rigging, video and audio departments circuit LED walls, projectors and speakers with the same kind of label from the same distros.
- Power distributors, dimmer racks and load-calculation tools need to know which loads share an outlet.

Verified against `mvr-spec.md` (MVR 1.6): the word *circuit* does not occur. The closest existing nodes do not cover the use case:

- `Connections` / `Connection` describes a physical link between two GDTF wiring-object geometries of two scene objects. It requires both ends to exist as objects with wiring geometry, and it carries no human-readable label. A crew member cannot read "LX1.1 / 3" from it.
- `CustomId` + `CustomIdType` is a numeric selection pool for consoles, not a power label, and it is inherited through multipatch, which is wrong for power (every physical unit has its own feed).
- `Function` is a free-text purpose string; abusing it for circuits collides with its intended use.
- `UserData` is explicitly not preserved across applications.

Consequently the circuit information is lost on every MVR export and has to travel in a separate CSV / paperwork, and receiving applications cannot group loads by circuit.

# Solution

Add an optional `Circuits` container with `Circuit` children to the `Fixture`, `VideoScreen` and `Projector` nodes. A circuit is identified only by the pair (`name`, `number`) stored on the object itself; there is no scene-level registry of circuits. This mirrors how planning tools model it today and lets objects from different departments be patched onto the same circuit without coordinating a shared list.

Design decisions:

- **Inline, not scene-level.** A central `<Circuits>` list under `AUXData` (like `Positions` or `Classes`) would introduce UUID collisions when merging MVRs from several departments and would force every exporter to emit definitions for circuits it only references. The (name, number) pair is the identity.
- **0..many per object.** LED walls, large moving lights and multi-cell units have more than one feed.
- **No electrical attributes.** Phase, rating, voltage and breaker are properties of the distributor, not of the load. Distributor and PDU tools derive them from the set of objects sharing a circuit; MVR only states *where* a device is connected.
- **No geometry link.** The `Circuit` does not reference a GDTF wiring object. This keeps it usable with the majority of GDTF files that do not model wiring geometry. The physical `Connection` node remains available and independent.
- **Not inherited through multipatch.** Every physical unit carries its own circuits.
- **Naming convention is a recommendation, character rules are normative.** `name` must not contain whitespace or commas so labels can be safely listed, printed and split by tools; the `<Position>.<MultiIndex>` shape is a SHOULD.

## Proposal 1

### Changes to GDTF

None.

### Changes MVR

#### New child on `Fixture`, `VideoScreen` and `Projector`

Add one row to the child-node tables of `Fixture`, `VideoScreen` and `Projector`:

| Child Node | Allowed Count | Value Type | Description |
| --- | --- | --- | --- |
| Circuits | 0 or 1 | | The container for power circuits for this object. |

`Truss`, `Support` and generic `SceneObject` are intentionally left out of this proposal; it can be extended later if needed.

#### New node `Circuits`

Node name: `Circuits`

| Child Node | Allowed Count | Description |
| --- | --- | --- |
| Circuit | 0 or any | Contains the definition of one power circuit connection. |

If the `Circuits` node is not present or contains no `Circuit` children, the object is not assigned to any circuit.

#### New node `Circuit`

Node name: `Circuit`

| Attribute Name | Attribute Value Type | Default Value | Description |
| --- | --- | --- | --- |
| name | String | Mandatory | The name of the circuit. Typically the name of the multicable, dimmer rack or power distributor the circuit belongs to. The value shall not contain whitespace or comma (`,`) characters. |
| number | Integer | Mandatory | The number of the circuit within `name`. The value shall be 1 or greater. |

Semantics:

- Two `Circuit` nodes refer to the same physical circuit when their `name` values are equal (case-sensitive, after trimming leading and trailing whitespace) and their `number` values are equal. All objects carrying the same pair are connected to the same circuit (e.g. several luminaires on a two-fer, or a speaker and a luminaire fed from the same outlet).
- `Circuit` is a logical label and is independent of `Connection`. Both may be present on the same object; neither implies the other.
- Circuits are not inherited from a multipatch parent. Every object, including multipatch children, defines its own circuits.

Recommended naming (informative):

- `name` SHOULD be `<Position>.<MultiIndex>`, where `<Position>` is the `name` of the `Position` node the object is attached to and `<MultiIndex>` is the index of the multicable (socapex, harting, ...) on that position. The dot (`.`) is the separator.
- `number` is then the circuit within that multicable (e.g. 1–6 for a 6-way socapex).
- When no multicable is used, `name` MAY be the name of the dimmer rack or power distributor and `number` the outlet number (e.g. `DIM-1` / `12`).

```xml
<Fixture name="Robe Robin MMX WashBeam" uuid="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6">
    ...
    <Position>77BCDE16-95A6-4725-9D04-16A0BD67CD1A</Position>   <!-- Position named "LX1" -->
    <Circuits>
        <Circuit name="LX1.1" number="3"/>
    </Circuits>
    ...
</Fixture>
```

#### Examples

1. First multicable on position `LX1`, third circuit:

   ```xml
   <Circuits>
       <Circuit name="LX1.1" number="3"/>
   </Circuits>
   ```

2. Second multicable on the same position, first circuit:

   ```xml
   <Circuits>
       <Circuit name="LX1.2" number="1"/>
   </Circuits>
   ```

3. Two fixtures on one two-fer. Both objects carry the identical pair, which makes them share the circuit:

   ```xml
   <Fixture name="PAR 64 #1" uuid="...">
       <Circuits>
           <Circuit name="LX1.1" number="4"/>
       </Circuits>
   </Fixture>
   <Fixture name="PAR 64 #2" uuid="...">
       <Circuits>
           <Circuit name="LX1.1" number="4"/>
       </Circuits>
   </Fixture>
   ```

Objects with more than one feed list several `Circuit` children, e.g. a `VideoScreen` with two power inputs:

```xml
<Circuits>
    <Circuit name="VID-DISTRO.1" number="1"/>
    <Circuit name="VID-DISTRO.1" number="2"/>
</Circuits>
```

#### Spec text

The full wording, including the insertion of *Node Definition: Circuits* / *Node Definition: Circuit* after *Node Definition: Connection* and the updated inline XML examples, is contained in the `mvr-spec.md` diff of this pull request.

## Implementation note (informative)

Mapping from planning tools that already carry the information:

| Vectorworks Spotlight (Lighting Device) | MVR |
| --- | --- |
| Circuit Name | `Circuit` attribute `name` |
| Circuit Number | `Circuit` attribute `number` |

Vectorworks today exports Instrument Type → `Name`, Channel → `FixtureID`, Unit Number → `UnitNumber`, Universe/Address → `Address`; this proposal adds the two remaining fields of the standard patch sheet.

Consoles are free to ignore `Circuits`. Distributor, PDU and load-calculation applications group all objects by identical (`name`, `number`) pairs to obtain the loads per circuit and derive phase, rating and breaker information from their own distributor model.
