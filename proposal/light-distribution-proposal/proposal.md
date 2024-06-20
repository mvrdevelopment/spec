# Support for more Photometric Data in MVR and GDTF

## Linked Issue


# Problem

We want to add the option to define the light distribution for fixtures inside the beam of the fixture. In simple works, this file define how even the light inside a beam is distributed.

# Proposal


## GDTF

### New Attribute Photometric

We will add attribute `Photometric` to the Beam Geometry. This defines the default light distribution for the fixture. 
We will add attribute `Photometric` to the Reference Geometry. This overwrites the default light distribution for the linked Beam. 
Inside the `ChannelFunction` and the `SubChannelSet` we also will add this this attribute, so that the fixture can change the behavior depending on the current status of the fixture. This will also define a range.

When the `Photometric` is an attribute of the `ChannelFunction` it applies to all Beams, while when it is in a child node  you can specify the beam it is for.

> **Note**
> We are currently discussing how `Photometric` can be defined as child of a `ChannelFunction`

The rules are the following:
- When a Beam does not have `Photometric`, it will not be affected by any `Photometric` definition in the file (Allow LED rings to have no photometric while the main light source have this and you still not need to use the `SubChannelSets`)
- Only one DMX Channel can have `Photometric` links inside their `ChannelFunction` or `SubChannelSet`.


Example Simple Fixture:

``` xml
<FixtureType>
    <Geometries>
        <Geometry 
            Name="Base" >
        <Axis
            Name="Yoke" >
            <Axis Name="Head" >
                <Beam  Name="Beam" Photometric="sample_default_file"/>
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
                <ChannelFunction Attribute="Zoom" DMXFrom="0/1" Name="Zoom 1" PhysicalFrom="45" PhysicalTo="5" PhotometricFrom="sample_default_file" PhotometricTo="narrow_file"/>
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
## Multi Beam defining

When a device has multiple beams, that need different Photometric files, we need to assign the files per Beam. This could be done either as a child of the `ChannelFunction`, or as a child of the `ChannelSet`.

When using the `ChannelSet`, we can use the DMX ranges from the `ChannelSet`. But we are also forced to use existing structure of `ChannelSet` or even create `ChannelSet` just for this propose.
When using the `ChannelFunction`, we need to also define a DMX range here. The requirements for the DMX range for channel set also applies for the `<Photometric>` node.

#### Option A: Use Children of the Channel Set to make multi Beam assign

Example Two Beam Fixture: 

``` xml
<FixtureType>
    <Geometries>
        <Geometry 
            Name="Base" >
        <Axis
            Name="Yoke" >
            <Axis Name="Head" >
                <Beam  Name="Beam1" Photometric="sample_default_file1"/>
                <Beam  Name="Beam2" Photometric="sample_default_file2"/>
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
                        <ChannelSetPhotometric
                            Beam="Beam1"
                            PhotometricFrom="sample_default_file1"
                            PhotometricTo="narrow_file1"
                        />
                        <ChannelSetPhotometric
                            Beam="Beam2"
                            PhotometricFrom="sample_default_file2"
                            PhotometricTo="narrow_file2"
                        />

                    </ChannelSet>
                    <ChannelSet DMXFrom="255/1" Name="Narrow">
                        <ChannelSetPhotometric
                            Beam="Beam1"
                            PhotometricFrom="narrow_file1"
                            PhotometricTo="narrow_file1"
                        />
                        <ChannelSetPhotometric
                            Beam="Beam2"
                            PhotometricFrom="narrow_file2"
                            PhotometricTo="narrow_file2"
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

#### Option B: Use Children of the Channel Function to make multi Beam assign


``` xml
<FixtureType>
    <Geometries>
        <Geometry 
            Name="Base" >
        <Axis
            Name="Yoke" >
            <Axis Name="Head" >
                <Beam  Name="Beam1" Photometric="sample_default_file1"/>
                <Beam  Name="Beam2" Photometric="sample_default_file2"/>
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
                    
                    <ChannelSet DMXFrom="0/1" Name="Wide" />
                    <ChannelSet DMXFrom="1/1" />
                    <ChannelSet DMXFrom="255/1" Name="Narrow"/>

                    <PhotometricSet
                        Beam="Beam1"
                        DMXFrom="0/1" 
                        PhotometricFrom="sample_default_file1"
                        PhotometricTo="narrow_file1"
                    />
                    <PhotometricSet
                        Beam="Beam2"
                        DMXFrom="0/1" 
                        PhotometricFrom="sample_default_file2"
                        PhotometricTo="narrow_file2"
                    />

                    <PhotometricSet
                        Beam="Beam1"
                        DMXFrom="255/1"
                        PhotometricFrom="narrow_file1"
                        PhotometricTo="narrow_file1"
                    />
                    <PhotometricSet
                        Beam="Beam2"
                        DMXFrom="255/1"
                        PhotometricFrom="narrow_file2"
                        PhotometricTo="narrow_file2"
                    />

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


