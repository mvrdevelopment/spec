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

1. Keep it as it is, and define the specific MVR properties in the objects - for example length in Cable:

In GDTF, the cable definition provides information about possible cable lengths, in MVR, the length is an instance field:

```xml
<FixtureType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
  <DMXModes>
    <DMXMode Description="" Geometry="Power Cable Schuko to Schuko" Name="Power Cable Schuko to Schuko"/>
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
Note: In GDTF, the DMX Mode must exist, even if empty, and link to the root geometry of the geometry tree.

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

Note: GDTFMode must be set on the Cable

2. Define specific modes for each MVR object type.

```xml
<FixtureType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
  <CableModes>
    <CableMode Description="" Geometry="Power Cable Schuko to Schuko" Name="Power Cable Schuko to Schuko"/>
  </CableModes>
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
```xml
  <Cable
    uuid="7C6B12E5-0AC9-45B2-99EA-5C7C9D9F5A10"
    name="Low Voltage PSU Feed 25m Hybrid"
    length="25.0"
    GDTFSpec="MyFixtureFamily.gdtf"
    CableMode="DMX cable">
  </Cable>
```

3. Define attributes of the specific object types into "DMX Mode" (for example cable length).

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

4. Besides DMX Mode, define specific modes for special devices: Speaker Mode, Cable Mode, and  a generic "Device mode" for the rest.

```xml
<FixtureType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
  <CableModes>
    <CableMode Description="" Geometry="Power Cable Schuko to Schuko" Name="Power Cable Schuko to Schuko"/>
  </CableModes>

  <DevicesModes>
    <DeviceMode Description="" Geometry="Power Cable Schuko to Schuko" Name="Power Cable Schuko to Schuko"/>
  </DeviceModes>
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
```xml
  <Cable
    uuid="7C6B12E5-0AC9-45B2-99EA-5C7C9D9F5A10"
    name="Low Voltage PSU Feed 25m Hybrid"
    length="25.0"
    GDTFSpec="MyFixtureFamily.gdtf"
    GDTFMode="DMX cable"
    DeviceMode="DMX cable"
    CableMode="DMX cable"
  </Cable>
```

5. Define new objects:

<FixtureType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
<AudioType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
<TrussType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
<CableType FixtureTypeID="755C3C57-609C-4F8F-8F69-80B96F090996" Name="My Cables" ...>
