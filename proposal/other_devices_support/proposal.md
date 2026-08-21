# Support for non-lighting fixtures

## Linked Issue

https://github.com/mvrdevelopment/spec/issues/318

# Problem

DMX Modes - DMX Mode is currently required for all devices, including Trusses, Power distros, Audio, Cables.

## General information

Currently, the DMX Mode is the entry point into the GDTF fixture type. If a
Speaker needs to be selected via MVR, then it is would currently be selected
via "DMX Mode" (GDTF Mode in MVR).

# Proposals

1. Keep it as it is and define the specific MVR properties in the objects - for example length in Cable:

In GDTF, the cable definition provides information about possible cable lengths, in MVR, the length a field on the instance of the cable:

```xml
<FixtureType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
  <DMXModes>
    <DMXMode Description="" Geometry="Power Cable Schuko to Schuko" Name="My Power Cable"/>
  </DMXModes>
  <Geometries>
    <Cable Name="Power Cable Schuko to Schuko"
     LengthMin="1.0"
     LengthMax="25.0"
     AvailableLengths="1.0,5.0,10.0,25.0"
     LengthArbitrary="True"
     ...
     />
     ...
```

In MVR, define Length:

```xml
  <Cable
    uuid="7C6B12E5-0AC9-45B2-99EA-5C7C9D9F5A10"
    name="Power cable"
    length="25.0"
    GDTFSpec="MyFixtureFamily.gdtf"
    GDTFMode="My Power Cable">
  </Cable>
```

Pros:
    - full backwards compatibility
    - easy addition to existing software
Cons:
    - In GDTF, the DMX Mode must exist and link to the root geometry of the geometry tree.
    - In MVR, the GDTFMode must be set, pointing to the DMX Mode

In MVR, Fixure, Truss, Support, Video screen, and Projector already exist, other specific objects like Cable, Speaker, Amplifier... can be added.


2. In GDTF, Define specific modes for each MVR object type, with fields specific for the device

```xml
<FixtureType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
  <CableModes>
    <CableMode Description="" Geometry="Power Cable Schuko to Schuko" Name="Power Cable Schuko to Schuko"
     LengthMin="1.0"
     LengthMax="25.0"
     AvailableLengths="1.0,5.0,10.0,25.0"
     LengthArbitrary="True"
    />
  </CableModes>
  <Geometries>
    <Cable Name="Power Cable Schuko to Schuko"
     ...
     />
     ...
```
```xml
  <Cable
    uuid="7C6B12E5-0AC9-45B2-99EA-5C7C9D9F5A10"
    name="Low Voltage PSU Feed 25m Hybrid"
    length="25.0"
    GDTFSpec="MyFixtureFamily.gdtf"
    CableMode="DMX cable">
  </Cable>
```
Cable:
GDTF: for device types primarily cables: CableModes - CableMode, MVR: Cable: CableMode, Length

Speaker:
GDTF: for devices primarly Speaker - SpeakerModes - SpeakerMode
MVR: Speaker - SpeakerMode


Note: Instead of "CableModes", "CableTypes - CableType" or other better wording could be used.

3. as #2, but also define generic "DeviceModes - DeviceMode" for non specific devices.

4. Define attributes of the specific object types into "DMX Mode" (for example cable length).

```xml
<FixtureType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
  <DMXModes>
    <DMXMode Description="" Geometry="Power Cable Schuko to Schuko" Name="Power Cable Schuko to Schuko"
     LengthMin="1.0"
     LengthMax="25.0"
     AvailableLengths="1.0,5.0,10.0,25.0"
     LengthArbitrary="True"
    />
  </DMXModes>
  <Geometries>
    <Cable Name="Power Cable Schuko to Schuko"
     LengthMin="1.0"
     LengthMax="25.0"
     AvailableLengths="1.0,5.0,10.0,25.0"
     LengthArbitrary="True"
     ...
     />
     ...
```
In MVR, define Length:

```xml
  <Cable
    uuid="7C6B12E5-0AC9-45B2-99EA-5C7C9D9F5A10"
    name="Low Voltage PSU Feed 25m Hybrid"
    length="25.0"
    GDTFSpec="MyFixtureFamily.gdtf"
    GDTFMode="DMX cable">
  </Cable>
```

5. Define new objects and specify properties/geometries that can be assigned:

For example:

<FixtureType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
<AudioType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
<TrussType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
<CableType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>

