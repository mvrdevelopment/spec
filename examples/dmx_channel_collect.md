# DMXChannelCollect

## DMX Channel Collect


The DMX channel collect is a child of the DMX mode.

As children a DMX channel collect has one or several DMX channels.

As children a DMX channel has one or several logical channels.

As children a logical channel has one or several channel functions.

As children a channel function can have channel sets. A channel function does not have to have children.

A channel set does not have children.


## DMX Channel Naming

You may want to name a "channel" for the user interface, for example to match manufacturer description or to use localized description. As the DMX Channel is defined in structure of: DMX Channel → Logical Channel → Channel Function, it is the Channel Function which, through linking to a Fixture Type Attribute, is explaining the function of the logical channel.

User defined name of a channel is therefore defined via first Channel Function or InitialFunction of a Logical Channel. GDTF data consumer (for example DMX console) then might choose "channel name" from the following places:

* name is taken from GDTF defined list of Fixture Type Attributes (Attribute Name and Attribute Pretty)
* name is taken from value of Name of first Channel Function of a Logical Channel
* name is taken from value of OriginalAttribute of first Channel Function of a Logical Channel

## Example – Basic Moving Head

The first example shows the DMX channel collect of a basic moving head. 

```
                <DMXChannels>
```

In this example the first DMX channel is used to describe the dimmer of the device. As this dimmer has a resolution of 8 bits only, one relative patch address is set with the Offset property. If the dimmer had a resolution of 16 bits, two relative patch addresses would be set. If the resolution of a channel was 32 bits, four relative patch address would be set. Example: Offset="1,2,3,4" patch the 32 bits channel to the four relative patch addresses 1,2, 3 and 4.

The highlight value of the dimmer is set to Full. Highlight is used to identify fixtures in the rig. The information is given as DMX value with an additional byte count. For example 128/1 equals the value of 128 in case of a one byte channel while this value equals 32768 in case of a 2 byte channel. 

The attribute "geometry" is used to set a link to a geometry of the current channel. The link is done by the name of the geometry. A DMX channel shall be linked to the geometry it is logically and physically located. In this example the basic moving head consists of four different geometries (Base, Yoke, Head, Beam). Base is the starting geometry, Yoke, on the other hand, is mounted to Base and Head is mounted to Yoke, while Beam is placed on the Head. Hence, Base is the parent of Yoke, Yoke is the parent of Head and Head the parent of Beam.

```
                    <DMXChannel Offset="1" Highlight="255/1" Geometry="Head">
```

Define one attribute per logical channel. If one DMX channel has to have more than one attribute, additional logical channels are needed. This is called a "split channel".

All attributes that are assigned to logical channels have to be described in the attributes section of the GDTF fixture type.

The xml attribute MibFade is given in seconds for the complete DMX range. The time value shall be used to limit the speed of DMX changes in  order to reduce noise during pre positioning of a device. MibFade only works for non-intensity output while DMXChangeTimeLimit always works independent of light output and is always used when set. DMXChangeTimeLimit shall protect the device of too fast DMX changes e.g. a color scroller fading from DMX 0/1 to DMX 255/1. DMXChangeTimeLimit is given in seconds for the complete DMX range.

```
                        <LogicalChannel Attribute="Dimmer" >
```
Define one attribute per channel function. This attribute can be the same that is defined for the logical channel. If one logical channel has to have more than one attribute, additional channel functions are needed. All attributes that are assigned to channel functions have to be described in the attributes section of the GDTF fixture type.

DMXFrom attribute is given as DMX value with an additional byte count. There must be no gaps in the range of the DMX values of one or more channel functions. Hence, the first channel function has to start with a DMXFrom="0/1". As there is no property DMXTo, the range of the attribute ends with the DMXFrom given for the next attribute or ends with the upper end of the value range of the DMX channel (255/1).

For example, the shutter channel of a device has the functions listed below:

- Shutter1 DMX 0-100
- Shutter1Strobe DMX 101-200
- Shutter1StrobeRandom DMX 201-255

The corresponding DMXFrom values of the three channel functions would be:

- Shutter1 DMXFrom="0/1"
- Shutter1Strobe DMXFrom="101/1"
- Shutter1StrobeRandom DMXFrom="201/1"


In this example the logical channel would have the attribute "Shutter1". "Shutter1 is the main attribute of the corresponding attributes that are used to describe the channel functions (Shutter1, Shutter1Strobe, Shutter1StrobeRandom). 

The attributes "PhysicalFrom" and "PhysicalTo" describe the physical values of the channel function. A dimmer has physical values between 0 = closed and 1 = open.

```
                            <ChannelFunction Attribute="Dimmer" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" >
```

Channel sets are used to define the function sets of a channel function. A channel function can have channel sets. In this example of the  dimmer channel, channel sets are defined for every 10% percent of intensity from 0% (closed) to 100% (open).

In channel functions there is also only a DMXFrom value given for every channel set while there are no gaps allowed for the value range of the DMX channel. The channel sets of the dimmer channel do not cover a certain range but are set to a specific value. Hence, additional channel sets are needed to fill these gaps. These channel sets do not have names as they function as placeholders. Channel sets can have physical values. In this case both PhysicalFrom and PhysicalTo must be defined. If no physical values are set, the physical values of the parent channel function are used. 

```
                                <ChannelSet Name="Closed" DMXFrom="0/1" />
                                <ChannelSet DMXFrom="1/1" />
                                <ChannelSet Name="10%" DMXFrom="25/1" />
                                <ChannelSet DMXFrom="26/1" />
                                <ChannelSet Name="20%" DMXFrom="51/1" />
                                <ChannelSet DMXFrom="52/1" />
                                <ChannelSet Name="30%" DMXFrom="76/1" />
                                <ChannelSet DMXFrom="77/1" />
                                <ChannelSet Name="40%" DMXFrom="102/1" />
                                <ChannelSet DMXFrom="103/1" />
                                <ChannelSet Name="50%" DMXFrom="128/1" />
                                <ChannelSet DMXFrom="129/1" />
                                <ChannelSet Name="60%" DMXFrom="153/1" />
                                <ChannelSet DMXFrom="154/1" />
                                <ChannelSet Name="70%" DMXFrom="179/1" />
                                <ChannelSet DMXFrom="180/1" />
                                <ChannelSet Name="80%" DMXFrom="204/1" />
                                <ChannelSet DMXFrom="205/1" />
                                <ChannelSet Name="90%" DMXFrom="230/1" />
                                <ChannelSet DMXFrom="231/1" />
                                <ChannelSet Name="Open" DMXFrom="255/1" />
                            </ChannelFunction>
                        </LogicalChannel>
                    </DMXChannel>
```

The second DMX channel represents a 16 bits pan. The property "Offset" has two relative patch addresses. The default value of the DMX channel is set to 50% as this is the home position of the pan. In case of a 16 bits pan this means a default of 32768/2. This DMX value could also be represented as 128/1. There is no highlight value. The DMX channel is linked to the geometry "Yoke" as this is where the functionality of pan is physically and logically located.

```
                    <DMXChannel Offset="2,3" Default="32768/2" Geometry="Yoke">
```

As this DMX channel is used to control the pan of the moving head, "Pan" is selected as attribute of the logical channel.

```
                        <LogicalChannel Attribute="Pan">
```

The attribute of the channel function is also set to pan. Here only one channel function is needed to describe the functionality of the logical channel. Physical values of pan and tilt are given based on their home position. In this case the pan of the moving head has a range of -270 degrees to +270 degrees.

```
                            <ChannelFunction Attribute="Pan" DMXFrom="0/1" PhysicalFrom="-270" PhysicalTo=" 270" >
```

One channel set is created for the home position of the pan (the second channel set listed below). In this example and most other cases, the home position is 50% pan movement. While the physical values of the pan range go from -270 to 270 degrees, the home position of the pan is 0 degrees. As the channel set does not have physical values the physical values of the channel function are used. DMX 32768/2 means 50% pan movement which means a position of 0° in the physical range of -270° to 270°. The first and the third channel set are used to close the gaps in the range of the DMX values.

```
                                <ChannelSet DMXFrom="0/1" />
                                <ChannelSet Name="Home" DMXFrom="32768/2" />
                                <ChannelSet DMXFrom="32769/2" />
                            </ChannelFunction>
                        </LogicalChannel>
                    </DMXChannel>
                    <DMXChannel Offset="4,5" Default="32768/2" Geometry="Head">
                        <LogicalChannel Attribute="Tilt">
                            <ChannelFunction Attribute="Tilt" DMXFrom="0/1" PhysicalFrom="-130" PhysicalTo=" 130" >
                                <ChannelSet DMXFrom="0/1" />
                                <ChannelSet Name="Home" DMXFrom="32768/2" />
                                <ChannelSet DMXFrom="32769/2" />
                            </ChannelFunction>
                        </LogicalChannel>
                    </DMXChannel>
                    <DMXChannel Offset="6" Highlight="0/1" Geometry="Head">
                        <LogicalChannel Attribute="Gobo1">
                            <ChannelFunction Attribute="Gobo1" DMXFrom="0/1" Wheel="GoboWheel">
```

There is one channel set for every slot of the gobo wheel. The link to the wheel in the wheel collect is given in the channel function. The WheelSlotIndex of a channel set is standardized to one. The numbering corresponds to the order of the wheel slots given in the corresponding wheel node. Dealing with the physical from/to values describe if the visualization of the wheel is snapped or if it is continuous. In case the snapping is preferred, the PhysicalFrom/To values are set to "0".

```
                                <ChannelSet Name="Open" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="1" />
                                <ChannelSet Name="Gobo 1" DMXFrom="42/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="2" />
                                <ChannelSet Name="Gobo 2" DMXFrom="85/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="3" />
                                <ChannelSet Name="Gobo 3" DMXFrom="127/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="4" />
                                <ChannelSet Name="Gobo 4" DMXFrom="169/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="5" />
                                <ChannelSet Name="Gobo 5" DMXFrom="212/1" PhysicalFrom="0" PhysicalTo="0" WheelSlotIndex="6" />
                            </ChannelFunction>
                        </LogicalChannel>
                    </DMXChannel>
                    <DMXChannel Offset="7" Highlight="0/1" Geometry="Head">
                        <LogicalChannel Attribute="Color1">
                            <ChannelFunction Attribute="Color1" DMXFrom="0/1" Wheel="ColorWheel">
```

In this example a continuous presentation of the color wheel is preferred. First channel set starts with PhysicalFrom="0" and PhysicalTo="0.5". This means that at the beginning of the range the first slot (= open) is fully visible, and the slot at the end of the range is half visible with the first half of the second slot also being visible (PhysicalFrom -0.5).

```
                                <ChannelSet Name="Open" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="0.5" WheelSlotIndex="1" />
                                <ChannelSet Name="Red" DMXFrom="36/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="2" />
                                <ChannelSet Name="Green" DMXFrom="73/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="3" />
                                <ChannelSet Name="Blue" DMXFrom="109/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="4" />
                                <ChannelSet Name="Cyan" DMXFrom="146/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="5" />
                                <ChannelSet Name="Magenta" DMXFrom="182/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="6" />
                                <ChannelSet Name="Yellow" DMXFrom="219/1" PhysicalFrom="-0.5" PhysicalTo="0" WheelSlotIndex="7" />
                            </ChannelFunction>
                        </LogicalChannel>
                    </DMXChannel>
                </DMXChannels>
```

## Example – Split Channel

The next example shows how to define a DMX channel that controls two different attributes. In this example it is the dimmer and the shutter of a device. This is called "Split Channel" because one DMX channel is split into two different logical channels. Split channels can also have more than two different attributes. Thus, needing more than two logical channels to describe the DMX channel.

In this example there are two different attributes used in one DMX channel, hence two logical channels are needed to describe the type of the DMX channel. The first half of the value range of the DMX channel is used to control the dimmer, the other half is used to control the shutter of the device.

- Dimmer 0-100% - DMX Range 0-127
- Shutter - DMX Range 128-255

The channel functions of a logical channel have to describe the entire value range of the DMX channel. No gaps are allowed. In this example we need two channel functions for every of the two logical channels. To fill undefined gaps, a channel function with the Attribute "NoFeature" is used.

- Dimmer 0-100% - DMX Range 0-127 and Shutter - DMX Range 128-255:
- Logical Channel - Attribute "Dimmer"
- Channel Function - Attribute "Dimmer" - DMX Range 0-127
- Channel Function - Attribute "NoFeature" - DMX Range 128-255
- Logical Channel - Attribute "Shutter1"
- Channel Function - Attribute "NoFeature" - DMX Range 0-127
- Channel Function - Attribute "Shutter1" - DMX Range 128-255

For every defined range of a logical channel a "NoFeature" range is created in the other logical channel and vice versa.

As explained before, only the DMX from values are given for a channel function.

```
<DMXChannel Offset="1" Highlight="127/1" Geometry="Head">
    <LogicalChannel Attribute="Dimmer">
        <ChannelFunction Attribute="Dimmer" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1"/>
        <ChannelFunction Attribute="NoFeature" DMXFrom="128/1" />
    </LogicalChannel>
    <LogicalChannel Attribute="Shutter1">
        <ChannelFunction Attribute="NoFeature" DMXFrom="0/1" />
        <ChannelFunction Attribute="Shutter1" DMXFrom="128/1" PhysicalFrom="0" PhysicalTo="1" />
    </LogicalChannel>
</DMXChannel>
```