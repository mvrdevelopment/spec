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

We need an flag if an object is an obstacle for the audio calculation or should be ignored.

We need to decide oif we create an object for the Listening Plane that just lives in the MVR, or let a Scene object just contain a GDTF with a listening plane inside.

We need to define, how we allow Line Arrays to define the load that this adds to the truss.

| Attribute Name | Value Type / Unit | Description  |
|----|----|----|
| AudioType               | Enum          | Obstacle, Ignore       | 

## User Story

Acceptance Criteria:

**Data Export from Various Sources:**
- Ability to export MVR files containing complete scenes and all objects from software such as Blender, Capture, Depence,grandMA3, Production Assist, Unreal Engine ,Vectorworks,WYSIWYG ,zactrack.
- Ensure that all relevant data, including geometric information and object properties, are correctly encapsulated in the MVR files.

**Importing and Building the Venue in Array Calc:**
- Import the MVR containing 3D data and geometries into Array Calc.
- Use the imported data to construct a detailed 3D venue that includes audience areas.

**Audio System Configuration in Array Calc:**
- Place and align arrays and speakers according to the predefined truss configurations within the MVR.
-Configure the cabling, digital signal processing (DSP) settings, and verify sight lines for optimal audio distribution and audience visibility.

**Export from Array Calc:**
- Export the newly positioned arrays and speakers with updated tilt angles.
- Export the bumper with load calculations for both front and rear attachments.
- Ensure all components such as cabling, DSP/amps settings, and speaker orientations are exported accurately.
- Export SPL (Sound Pressure Level) textures mapping on audience areas, if applicable.

**Reintegration into Other MVR-Compatible Software:**
- Import the updated MVR files into another MVR-compatible application.
- Adjust the positioning of arrays and speakers to maintain sight lines.
- Display the SPL textures to visually represent the sound levels across different audience zones.