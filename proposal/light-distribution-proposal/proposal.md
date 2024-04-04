# Support for Spectral Distribution in MVR and GDTF

## Linked Issue


# Problem

We want to add the option to define the light distribution for fixtures inside the beam of the fixture. In simple works, this file define how even the light inside a beam is distributed.

# Proposal


## GDTF

### New Attribute LightDistribution

We will add attribute LightDistribution to the Beam Geometry. This defines the default light distribution for the fixture. 
Inside the ChannelSet we also will add this this attribute, so that the fixture can change the behavior depending on the current status of the fixture. 



## MVR

Currently there will be no impact on the MVR.


