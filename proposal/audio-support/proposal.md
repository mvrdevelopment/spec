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

We will add a new geometry type speaker. This represents one speaker inside the device and will act like the origin of the audio source. By default a audio device with two "real-world" speakers will have one GDTF Geometry speakers, as the properties for visualization and planning will be combined by this two things.

The attributes in addition to the default geometry attributes are:

| Attribute Name | Value Type / Unit | Description  |
|----|----|----|
| Frequency Min               | Number / Hertz          | Minimal Frequency of the Speaker  (-5db ??)       | 
| Frequency Max               | Number / Hertz          | Maximal Frequency of the Speaker  (-5db ??)       | 
| AngleVertical               | Number / Degree          | Angle of the vertical distribution       | 
| AngleHorizontal               | Number / Degree          | Angle of the horizontal distribution       | 
| MaxSPL               | Number / dB          | Max Sound Pressure (1m ??)       | 
| Impedance               | Number / Ohm          | Nominal impedance of the speaker       | 


### New Geometry Type Listening Plane

Wer will add a new geometry that defines a listening plane. A listening plane is an area that will be used the calculate acoustics data at the given point. We will add this to GDTF, so that you can define spots of interest directly in a GDTF. An example for a use case is a chair, where you define the Listening Plane in the position where the ears of an person sitting normally are. 

The use case is here that any application can define this zones of interest and programs that can calculate this can export additional result data for this. We will define the Listening plane format in such a way it is parametric, to that it is easy for all software to modify this.

The attributes in addition to the default geometry attributes are:

| Attribute Name | Value Type / Unit | Description  |
|----|----|----|
| TypeOfListeningPlane               | Enum          | Rectangle, Triangle, ArcSegment, Eleptic, Cube       | 
| PR               | Array of 8 Points for Rectangle          |  Defines the 2D points of the       | 
| PT               | Array of 6 Points for Triangle          |        | 
| PA               | Array of Points for ArcSegment         |        | 
| PE               | Array of Points  for Eleptic        |        | 
| Height              | Number          | For Cubes        | 
| Width               | Number          | For Cubes       | 
| Depth               | Number          | For Cubes       | 

## MVR

We need to add data for the venue transfer.

We need to add data how the individual speakers, amps usw are placed and wired.


