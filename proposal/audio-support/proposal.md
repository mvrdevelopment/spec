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

| Attribute Name | Value Type / Unit | Description  |
|----|----|----|
| Frequency Min               | Number / Hertz          | Minimal Frequency of the Speaker  (-5db ??)       | 
| Frequency Max               | Number / Hertz          | Maximal Frequency of the Speaker  (-5db ??)       | 
| AngleVertical               | Number / Degree          | Angle of the vertical distribution       | 
| AngleHorizontal               | Number / Degree          | Angle of the horizontal distribution       | 
| MaxSPL               | Number / dB          | Max Sound Pressure (1m ??)       | 
| Impedance               | Number / Ohm          | Nominal impedance of the speaker       | 

### New Geometry Type Listening Plane


## MVR

We need to add data for the venue transfer.

We need to add data how the individual speakers, amps usw are placed and wired.


