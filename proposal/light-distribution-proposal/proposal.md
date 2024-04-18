# Support for Spectral Distribution in MVR and GDTF

## Linked Issue


# Problem

We want to add the option to define the light distribution for fixtures inside the beam of the fixture. In simple works, this file define how even the light inside a beam is distributed.

# Proposal


## GDTF

### New Attribute LightDistribution

We will add attribute `LightDistribution` to the Beam Geometry. This defines the default light distribution for the fixture. 
Inside the `ChannelFunction` and the `SubChannelSet` we also will add this this attribute, so that the fixture can change the behavior depending on the current status of the fixture. This will also define a range.

When the `LightDistribution` in inside the `ChannelFunction` it applies to all Beams, while when it is in a `SubChannelSet` you can specify the beam it is for.

The rules are the following:
- When a Beam does not have `LightDistribution`, it will not be affected by any `LightDistribution` definition in the file (Allow LED rings to have no spectral data while the main light source have this and you still not need to use the `SubChannelSets`)
- Only one DMX Channel can have `LightDistribution` links inside their `ChannelFunction` or `SubChannelSet`.

Example Simple Fixture:

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
                <ChannelFunction Attribute="Zoom" DMXFrom="0/1" Name="Zoom 1" PhysicalFrom="45" PhysicalTo="5" LightDistributionFrom="sample_default_file" LightDistributionTo="narrow_file"/>
                    <ChannelSet DMXFrom="0/1" Name="Wide" />
                    <ChannelSet DMXFrom="1/1" />
                    <ChannelSet DMXFrom="255/1"/>
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

Example Two Beam Fixture:

```
<FixtureType>
    <Geometries>
        <Geometry 
            Name="Base" >
        <Axis
            Name="Yoke" >
            <Axis Name="Head" >
                <Beam  Name="Beam1" LightDistribution="sample_default_file1"/>
                <Beam  Name="Beam2" LightDistribution="sample_default_file2"/>
            </Axis>
        </Axis>
        </Geometry>
        </Geometry>
    </Geometries>
    <DMXModes>
        <DMXMode Description="" Geometry="Base" Name="Mode 1">
        <DMXChannels>
            <DMXChannel Geometry="Yoke" >
            <LogicalChannel >
                <ChannelFunction Attribute="Zoom" DMXFrom="0/1" Name="Zoom 1" PhysicalFrom="45" PhysicalTo="5">
                    <ChannelSet DMXFrom="0/1" Name="Wide" >
                    </ChannelSet>
                    <ChannelSet DMXFrom="1/1" >
                        <SubChannelSet
                            Beam="Beam1"
                            LightDistributionFrom="sample_default_file1"
                            LightDistributionTo="narrow_file1"
                        />
                        <SubChannelSet
                            Beam="Beam2"
                            LightDistributionFrom="sample_default_file2"
                            LightDistributionTo="narrow_file2"
                        />

                    </ChannelSet>
                    <ChannelSet DMXFrom="255/1" Name="Narrow">
                        <SubChannelSet
                            Beam="Beam1"
                            LightDistributionFrom="narrow_file1"
                            LightDistributionTo="narrow_file1"
                        />
                        <SubChannelSet
                            Beam="Beam2"
                            LightDistributionFrom="narrow_file2"
                            LightDistributionTo="narrow_file2"
                        />

                    </ChannelSet>
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
    - LED Ring and normal beam (You only need the beam as IES file)
    - Multi head fixtures (You need for each an individual beam, and it also needs to change)

- Only one IES file (or and interpolation between two IES files) can be active. This is challenging when multiple Attributes have effects on the light output.

- Do we need to add measurement instruction to the GDTF spec or only reference the IES spec. 
    - You measure devices in such a distance that the actual shape of the device has no influence on the measurement. For strip lights, this means a big distance. Not all can measure strip lights at such distance. The distance that IES recommends is 7x the beam diameter.


## MVR

Currently there will be no impact on the MVR.


