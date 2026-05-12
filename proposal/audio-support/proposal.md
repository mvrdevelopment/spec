# Support for Audio Devices in MVR and GDTF

## Linked Issue


# Problem

We want to fully express audio devices in GDTF and MVR.

We need to express the relevant data for:
- Speakers
- Amplifiers
- Signal Processors
- Cabling
- Power Calculation
- Networking


# Proposal


## GDTF

### New Geometry Type Speaker

We will add a new geometry type `Speaker`. This represents one speaker inside the device and acts as the origin of the audio source. By default, an audio device with two "real-world" speakers can have one GDTF `Speaker` geometry if the properties for visualization and planning are combined.

The attributes in addition to the default geometry attributes are:

| Attribute Name | Value Type / Unit | Description  |
|----|----|----|
| Frequency Min | Number / Hertz | Minimal frequency of the speaker at the -6 dB mark. |
| Frequency Max | Number / Hertz | Maximal frequency of the speaker at the -6 dB mark. |
| Sound Angle Horizontal Left | Number / Degree | Horizontal dispersion angle to the left side of the speaker axis. |
| Sound Angle Horizontal Right | Number / Degree | Horizontal dispersion angle to the right side of the speaker axis. |
| Sound Angle Vertical Up | Number / Degree | Vertical dispersion angle above the speaker axis. |
| Sound Angle Vertical Down | Number / Degree | Vertical dispersion angle below the speaker axis. |
| Sound Angle Rotation | Number / Degree | Rotation of the sound dispersion around the speaker axis. This allows asymmetric dispersion, for example an asymmetric sound field rotated by 45 degrees. |
| Max SPL | Number | Maximum sound pressure level measured at 1 meter from the speaker. The value is interpreted together with the SPL format attributes below. |
| Max SPL Excitation Signal | Enum | `PinkNoise`, `IEC60268ProgramSimulationNoise`, `EIA426BLoudspeakerTestSignal`, `AES75MNoise`. |
| Max SPL Frequency Weighting | Enum | `None`, `A`, `C`. |
| Max SPL Level Unit | Enum | `dB`, `dBZ`, `dBSPL`, `dBA`, `dBC`. |
| Max SPL Time Weighting | Enum | `Fast`, `Slow`, `Leq`, `Peak`. |
| Max SPL Time Unit | Enum | `F`, `S`, `Leq`, `LAeq`, `LCeq`. |
| Impedance | Number / Ohm | Nominal impedance of the speaker. |

TODO: define defaults, exact attribute names.

Sound angles are intentionally not defined as adjustable ranges in this proposal. The proposal defines the actual sound dispersion with independent left, right, up, and down angles plus one rotation value. This supports asymmetric dispersion without requiring separate min/max angle ranges.

The SPL excitation signal, frequency weighting, level unit, time weighting, and time unit are independent metadata fields and can be used in any valid combination. The format only describes the stored value; applications should not convert the value when the format changes. If an application changes the SPL format for an existing value, it should clear the value and require a new value to be entered.

### New Geometry Type Listening Plane

We will add a new geometry type `ListeningPlane`. A listening plane defines an infinitesimally thin area that can be used to calculate acoustic data. The listening plane is placed in the GDTF hierarchy like other geometries, so spots of interest can be defined directly in a GDTF. Example use cases are audience areas or the ear position of a person sitting in a chair.

A listening plane is defined by a referenced `Geometry3D` file. This allows a polygon with any number of points instead of a fixed set of parametric shapes. The surface has no height range, width, depth, or volume; it is a single thin layer located by the geometry transform.

Example:

```xml
<ListeningPlane name="Listening Plane" uuid="CE95360F-AF06-4715-93DA-FAE02E4C3E49">
    <Geometries>
        <Geometry3D fileName="ce95360f-af06-4715-93da-fae02e4c3e49.glb"/>
    </Geometries>
</ListeningPlane>
```

The referenced geometry should contain the polygonal listening surface. Applications that calculate acoustic data can use this surface as the target area for result data such as sound pressure level maps.

## MVR

We need to add data for the venue transfer.

We need to add data for how the individual speakers, amplifiers, signal processors, cabling, and networks are placed and wired.

We need a flag that defines whether an object is an obstacle for the audio calculation or should be ignored.

Listening planes should be transferred as scene objects that reference GDTF data containing a `ListeningPlane`, instead of defining an MVR-only listening plane object.

We need to define how line arrays describe the load that they add to the truss.

| Attribute Name | Value Type / Unit | Description  |
|----|----|----|
| Audio Type | Enum | `Obstacle`, `Ignore`. |
| Audio Material Name | String | Name of the material to use for audio analysis. This is used by receiving applications to derive reflectiveness or other acoustic properties. MVR only transfers the material name and does not define the acoustic material model. |

## User Story

Acceptance Criteria:

**Data Export from Various Sources:**
- Ability to export MVR files containing complete scenes and all objects from software such as Blender, Capture, Depence, grandMA3, Production Assist, Unreal Engine, Vectorworks, WYSIWYG, zactrack.
- Ensure that all relevant data, including geometric information and object properties, are correctly encapsulated in the MVR files.

**Importing and Building the Venue in Array Calc:**
- Import the MVR containing 3D data and geometries into Array Calc.
- Use the imported data to construct a detailed 3D venue that includes audience areas.

**Audio System Configuration in Array Calc:**
- Place and align arrays and speakers according to the predefined truss configurations within the MVR.
- Configure the cabling, digital signal processing (DSP) settings, and verify sight lines for optimal audio distribution and audience visibility.

**Export from Array Calc:**
- Export the newly positioned arrays and speakers with updated tilt angles.
- Export the bumper with load calculations for both front and rear attachments.
- Ensure all components such as cabling, DSP/amps settings, and speaker orientations are exported accurately.
- Export SPL (Sound Pressure Level) textures mapping on audience areas, if applicable.

**Reintegration into Other MVR-Compatible Software:**
- Import the updated MVR files into another MVR-compatible application.
- Adjust the positioning of arrays and speakers to maintain sight lines.
- Display the SPL textures to visually represent the sound levels across different audience zones.
