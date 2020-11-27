# Breaks

DMX breaks is used whenever a fixture needs more than one DMX starting address.
For example, there are fixtures that do not have an integrated dimmer. Such moving heads have one DMX address and the lamp inside is connected to an external dimmer in the rack of Dimmer City. The dimmers mounted in a rack have a different DMX address (may have a different universe even). A different example is a fixture that is connected to an external dimmer, but one that has an additional color scroller. The external dimmer has a different DMX starting address compared to the PSU of the color scroller.

## Example – Dimmer with Color Scroller ==

The following example shows a dimmer with a color scroller. The dimmer is assigned to break 1, the ColorScroller (attribute Color1) is assigned to break 2. Both have a relative DMX patch address of 1. The property DMXBreak="1" is not shown for the dimmer as break 1 is the default. 

```
<DMXMode Name="Mode 1" Geometry="Body">
    <DMXChannels>
        <DMXChannel Offset="1" Highlight="255/1" Geometry="Body">
            <LogicalChannel Attribute="Dimmer" Master="Grand">
                <ChannelFunction Attribute="Dimmer" DMXFrom="0/255" PhysicalFrom="0" PhysicalTo="1" RealFade="0" />
            </LogicalChannel>
        </DMXChannel>
        <DMXChannel DMXBreak="2" Offset="1" Highlight="0/1" Geometry="Body">
            <LogicalChannel Attribute="Color1" >
                <ChannelFunction Attribute="Color1" DMXFrom="0/1" Wheel="ColorScroller">
                    <ChannelSet Name="Gel1" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="0.5" WheelSlotIndex="1" />
                    <ChannelSet Name="Gel2" DMXFrom="51/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="2" />
                    <ChannelSet Name="Gel3" DMXFrom="102/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="3" />
                    <ChannelSet Name="Gel4" DMXFrom="153/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="4" />
                    <ChannelSet Name="Gel5" DMXFrom="204/1" PhysicalFrom="-0.5" PhysicalTo="0" WheelSlotIndex="5" />
                </ChannelFunction>
            </LogicalChannel>
        </DMXChannel>
    </DMXChannels>
    <Relations />
</DMXMode>
```

Breaks can also be assigned to a geometry that is linked to by geometry references. In this case a DMX offset is needed for every break a geometrical reference contains. 

## Example – Multiple Breaks in Geometrical References ==

The following example deals with a fixture type whose four dimmer channels (four conventionals) are mounted to a bar. Each of the four conventionals also have a color scroller. There is one geometry that has the type "Geometry" to which reference is made by four geometry references. Each of the geometry references has a DMX offset for each of the two breaks.

```
<Geometries>
    <Geometry Name="Head" Model="Head">
        <Beam Name="Beam" Model="Beam" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.200000}{0.000000,0.000000,0.000000,1.000000}" LampType="Halogen" PowerConsumption="1000" LuminousFlux="28000" ColorTemperature="3200" BeamAngle="14" FieldAngle="22" BeamRadius="0.1" />
    </Geometry>
    <Geometry Name="Body" Model="Body">
        <GeometryReference Name="Head1" Position="{1.000000,0.000000,0.000000,-0.600000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.225000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Head">
            <Break DMXOffset="1" />
            <Break DMXBreak="2" DMXOffset="1" />
        </GeometryReference>
        <GeometryReference Name="Head2" Position="{1.000000,0.000000,0.000000,-0.200000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.225000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Head">
            <Break DMXOffset="2" />
            <Break DMXBreak="2" DMXOffset="2" />
        </GeometryReference>
        <GeometryReference Name="Head3" Position="{1.000000,0.000000,0.000000,0.200000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.225000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Head">
            <Break DMXOffset="3" />
            <Break DMXBreak="2" DMXOffset="3" />
        </GeometryReference>
        <GeometryReference Name="Head4" Position="{1.000000,0.000000,0.000000,0.600000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.225000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Head">
            <Break DMXOffset="4" />
            <Break DMXBreak="2" DMXOffset="4" />
        </GeometryReference>
    </Geometry>
</Geometries>
<DMXModes>
    <DMXMode Name="Mode 1" Geometry="Body">
        <DMXChannels>
            <DMXChannel Offset="1" Highlight="255/1" Geometry="Head">
                <LogicalChannel Attribute="Dimmer" >
                    <ChannelFunction Attribute="Dimmer" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" RealFade="0" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel DMXBreak="2" Offset="1" Highlight="0/1" Geometry="Head">
                <LogicalChannel Attribute="Color1" >
                    <ChannelFunction Attribute="Color1" DMXFrom="0/1" PhysicalFrom="-0.5" PhysicalTo="0.5" Wheel="ColorScroller">
                        <ChannelSet Name="Gel1" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="0.5" WheelSlotIndex="1" />
                        <ChannelSet Name="Gel2" DMXFrom="51/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="2" />
                        <ChannelSet Name="Gel3" DMXFrom="102/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="3" />
                        <ChannelSet Name="Gel4" DMXFrom="153/1" PhysicalFrom="-0.5" PhysicalTo="0.5" WheelSlotIndex="4" />
                        <ChannelSet Name="Gel5" DMXFrom="204/1" PhysicalFrom="-0.5" PhysicalTo="0" WheelSlotIndex="5" />
                    </ChannelFunction>
                </LogicalChannel>
            </DMXChannel>
        </DMXChannels>
        <Relations />
    </DMXMode>
</DMXModes>
```