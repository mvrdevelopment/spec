# Mode Dependencies

Some attributes change function based on the value of a different attribute. An attribute that controls the rotation mode of a gobo, for example. Imagine a fixture that has an attribute that is used to select a gobo on a gobo wheel. First half of the DMX range will select the different gobos on the wheel, but the gobos are in an "index" mode. A second attribute controls the rotation of the gobo. When the selected gobo is in index mode, the rotation is set to be a degree number. The second half of the selection attribute also selects all the gobos on the wheel, but now in a continuous rotation mode. The rotation attribute will now control the rotation speed and direction.

The following example describes the rotating gobo of a device. There are two DMX channels that are used to control this unit. The logical channel of the first DMX channel (Attribute `Gobo1`) has two channel functions. The first channel function (Attribute `Gobo1`) describes the selection of indexed and rotating gobos. There are two value ranges that describe the selection of the individual gobos in indexed or continuous rotation mode. The second channel function (Attribute Gobo1WheelSpin) is used to describe the continuous rotation of the whole gobo wheel. The logical channel (Attribute `Gobo1Pos`) of the second DMX channel has two channel functions. The first channel function (Attribute Gobo1Pos) describes the indexed mode of the rotating gobos. The second channel function (Attribute `Gobo1PosRotate`) describes the continuous rotation mode of the rotating gobos.


The functionality of these different ranges of the two DMX channels is linked by mode dependencies.

If an indexed gobo is selected on the first DMX channel, the second channel controls the index rotation. If a continuous rotating gobo is selected on the first channel, the second channel controls the direction and the speed of the rotating gobo.

The DMX value range of the selection of an indexed gobo on channel 1 goes from DMX 0/1 to DMX 60/1; The value range of the selection of rotating gobos goes from DMX 61/1 to DMX 110/1.

```
        <DMXModes>
            <DMXMode Name="Default" Geometry="Head">
                <DMXChannels>
```

First DMX channel: selection of index or continuous rotating gobos / continuous rotation of the entire gobo wheel.

```
                    <DMXChannel Offset="1"  Geometry="Head">
                        <LogicalChannel Attribute="Gobo1">
                            <ChannelFunction Attribute="Gobo1" DMXFrom="0/1" Wheel="GoboWheel1">
```

Start of the first range of values: selection of indexed gobos.

```
                                <ChannelSet Name="Open" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="1" />
                                <ChannelSet Name="Gobo 1 index" DMXFrom="11/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="2" />
                                <ChannelSet Name="Gobo 2 index" DMXFrom="21/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="3" />
                                <ChannelSet Name="Gobo 3 index" DMXFrom="31/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="4" />
                                <ChannelSet Name="Gobo 4 index" DMXFrom="41/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="5" />
                                <ChannelSet Name="Gobo 5 index" DMXFrom="51/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="6" />
```

Start of the second range of values: selection of continuous rotating gobos.

```
                                <ChannelSet Name="Gobo 1 rot" DMXFrom="61/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="2" />
                                <ChannelSet Name="Gobo 2 rot" DMXFrom="71/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="3" />
                                <ChannelSet Name="Gobo 3 rot" DMXFrom="81/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="4" />
                                <ChannelSet Name="Gobo 4 rot" DMXFrom="91/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="5" />
                                <ChannelSet Name="Gobo 5 rot" DMXFrom="101/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="6" />
                            </ChannelFunction>
                            <ChannelFunction Attribute="Gobo1WheelSpin" DMXFrom="111/1" >
                                <ChannelSet Name="CCW" DMXFrom="111/1" PhysicalFrom="-60" PhysicalTo="0" />
                                <ChannelSet Name="Stop" DMXFrom="183/1" PhysicalFrom="0" PhysicalTo="0" />
                                <ChannelSet Name="CW" DMXFrom="184/1" PhysicalFrom="0" PhysicalTo="60" />
                            </ChannelFunction>
                        </LogicalChannel>
                    </DMXChannel>
```

Second DMX channel: angle of indexed rotation of gobo / direction and speed of continuous rotation.

```
                    <DMXChannel Offset="2" Geometry="Head">
                        <LogicalChannel Attribute="Gobo1Pos">
```

First channel function: angle of indexed rotation of gobo. This channel function shall be active if Gobo1 - which is the ModeMaster in this example - is in the DMX range of 0/1 to 60/1. The ModeMaster can be either a DMXChannel `Head_Gobo1` or a ChannelFunction `Head_Gobo1.Gobo1.Gobo1 1`.

If the ModeMaster is a DMXChannel use "Name of the DMXChannel". The name of the DMX channel is composed from the name of the linked geometry and the first logical channel.

For this example ModeMaster DMXChannel would be: `Head_Gobo1`

If the ModeMaster is a ChannelFunction use "Name of the DMX channel.Name of the logical channel.Name of the channel function"

The name of the logical channel is the name of its attribute.

The name of the channel function can be edited by the user. By default, the name is composed from the name of the Attribute and an enumerated count that depends on the index of the channel function.

Example:
- Gobo1 1
- Gobo1WheelSpin 2

For this example ModeMaster Channel Function would be: `Head_Gobo1.Gobo1.Gobo1 1`
```
                            <ChannelFunction Attribute="Gobo1Pos" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="540" ModeMaster="Head_Gobo1" ModeFrom="0/1" ModeTo="60/1" />
```
Second channel function: direction and speed of continuous rotation. This channel function shall be active if Gobo1 is in the DMX range of 61/1 to 110/1.
```
                            <ChannelFunction Attribute="Gobo1PosRotate" DMXFrom="0/1" PhysicalFrom="-150" PhysicalTo="150" ModeMaster="Head_Gobo1" ModeFrom="61/1" ModeTo="110/1">
                                <ChannelSet Name="CW" DMXFrom="0/1" PhysicalFrom="-150" PhysicalTo="0" />
                                <ChannelSet Name="Stop" DMXFrom="128/1" PhysicalFrom="0" PhysicalTo="0" />
                                <ChannelSet Name="CCW" DMXFrom="129/1" PhysicalFrom="0" PhysicalTo="150"/>
                            <ChannelFunction/>
                        </LogicalChannel>
                    </DMXChannel>
                </DMXChannels>
                <Relations />
            </DMXMode>
        </DMXModes>
```