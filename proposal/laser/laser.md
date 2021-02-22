# Laser Support for GDTF

## Linked Issue

There is not an issue for this in the repo.

# Problem

We will add the support for Lasers in GDTF. We will take the approach to define the general properties of a laser, but not decribe the actual controlling interface, as this is often not open.

# Solution

We will add a new geometry type for lasers in GDTF. This allow you define the properties inside a normal GDTF using the normal way.

## Proposal 1

### Changes to GDTF

| XML Attribute Name | Value Type                                | Description                                                                                                    |
|--------------------|-------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| Name               | [Name](#user-content-attrtype-name )      | The unique name of the geometry.                                                                               |
| Model              | [Name](#user-content-attrtype-name )      | Link to the corresponding model.                                                                               |
| Position           | [Matrix](#user-content-attrtype-matrix )  | Relative position of geometry; Default value: Identity Matrix                                                  |
| ColorType          | [Enum](#user-content-attrtype-enum )      | The currently defined unit values are: “RGB”, “SingleWaveLength”,  Default: RGB.                               |
| Color              | [Float](#user-content-attrtype-float)     | Required if [ColorType] is "SingleWaveLength"; Unit:nm (nanometers)                                            |
| OutputStrength     | [Float](#user-content-attrtype-float)     | Output Strength of the Laser; Unit: mW (milliwatt)                                                             |
| Emitter            | [Node](#user-content-attrtype-node )      | Optional link to the emitter group. The starting point is the [Emitters](#user-content-emitter-collect ) node. |
| BeamDiameter       | [Float](#user-content-attrtype-float)     | Beam diameter where it leaves the projector; Unit: mm (millimeters)                                            |
| BeamDivergenceMin  | [Float](#user-content-attrtype-float)     | Minimum beam divergence; Unit: mrad  (milliradian)                                                             |
| BeamDivergenceMax  | [Float](#user-content-attrtype-float)     | Maximum beam divergence; Unit: mrad  (milliradian)                                                             |
| ScanAnglePan       | [Float](#user-content-attrtype-float)     | Possible Total Scan Angle Pan of the beam. Assumes symetrical output; Unit: Degree                             |
| ScanAngleTilt      | [Float](#user-content-attrtype-float)     | Possible Total Scan Angle Pan of the beam. Assumes symetrical output; Unit: Degree                             |
| ScanSpeed          | [Float](#user-content-attrtype-float)     | Speed of the beam; Unit: kilo point per second                                                                 |




The following example shows a Laser Geometry:

```
 <Laser 
    Name="Fancy Laser" 
    Model="Laser Model"
    Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.257000}{0,0,0,1}" 
    ColorType="RGB" 
    OutputStrength="5" 
    Emitter="RGB LASER" 
    BeamDiameter="100"
    BeamDivergenceMin="1" 
    BeamDivergenceMax="4" 
    ScanAnglePan="90" 
    ScanAngleTilt="45" 
    ScanSpeed="7.47" 
/>
```

### Changes MVR

We will add a new Node for Layer Objects

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object               |

| Child Node                        | Allowed Count | Description                                                                     |                                                                                          |
|-----------------------------------|---------------|---------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| [Matrix](#node-definition-matrix) | 0 or 1        | The location and orientation of the object inside the parent coordinate system. |                                                                                          |
| GDTFSpec                          | 1             | [FileName](#user-content-attrtype-filename)                                     | The name of the file containing the GDTF information for this light fixture.             |
| GDTFMode                          | 1             | [String](#user-content-attrtype-string)                                         | The name of the used DMX mode. This has to match the name of a DMXMode in the GDTF file. |
| DeviceID                          | 1             | [String](#user-content-attrtype-string)                                         | The Fixture ID of the lighting fixture. This is the short name of the fixture.           |
