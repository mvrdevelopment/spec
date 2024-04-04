# Support for Spectral Distribution in MVR and GDTF

## Linked Issue


# Problem

We want to add the option to define the light distribution for fixtures inside the beam of the fixture. In simple works, this file define how even the light inside a beam is distributed.

# Proposal


## GDTF

### New Attribute LightDistribution

We will add attribute LightDistribution to the Beam Geometry. This defines the default light distribution for the fixture. 
Inside the ChannelSet we also will add this this attribute, so that the fixture can change the behavior depending on the current status of the fixture. 

Example:

```
<FixtureType>
    <Geometries>
        <Geometry 
            Name="Base" >
        <Axis
            Name="Yoke" >
            <Axis Name="Head" >
                <Beam  Name="Beam" LightDistribution="sample_default_file"/>
            </Axis>
        </Axis>
        </Geometry>
        </Geometry>
    </Geometries>
    <DMXModes>
        <DMXMode Description="" Geometry="Base" Name="Mode 1">
        <DMXChannels>
            <DMXChannel Geometry="Beam" >
            <LogicalChannel >
                <ChannelFunction Attribute="Zoom" DMXFrom="0/1" Name="Zoom 1" PhysicalFrom="45" PhysicalTo="5">
                <ChannelSet DMXFrom="0/1" Name="Wide" />
                <ChannelSet DMXFrom="1/1" LightDistributionFrom="sample_default_file" LightDistributionTo="narrow_file"/>
                <ChannelSet DMXFrom="255/1" Name="Narrow" LightDistributionFrom="narrow_file" LightDistributionTo="narrow_file"/>
                </ChannelFunction>
            </LogicalChannel>
            </DMXChannel>
        </DMXChannels>
        <Relations/>
        <FTMacros/>
        </DMXMode>
    </DMXModes>
</FixtureType>
```

#### Challenges
- How do we handle multiple beam in one fixture
    - Multi LED Strip Light (Challenge is how you measure device)
    - Multi LED Wash Light (You want to measure all at once, but represent the beam as one)
    - LED Ring and normal beam (You only need the beam as AES file)
    - Multi head fixtures (You need for each an individual beam, and it also needs to change)


## MVR

Currently there will be no impact on the MVR.

