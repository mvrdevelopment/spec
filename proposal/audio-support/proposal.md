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



## MVR

We need to add data for the venue transfer.

We need to add data how the individual speakers, amps usw are placed and wired.


