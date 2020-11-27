# DMXModes

Many fixture types have more than one DMX mode (e.g., different channel count or different firmware versions). These modes can be described as several modes in one GDTF fixture type.

This example demonstrates an LED par with three different modes that differ in their attributes and the count of their DMX channels.

Each mode has a name, a link to a start geometry, and its own DMX channel collect.

```
<DMXModes>
<!--
First Mode
 -->
    <DMXMode Name="RGB Mode" Geometry="Body">
        <DMXChannels>
            <DMXChannel Offset="1" Highlight="255/1" Geometry="Body">
                <LogicalChannel Attribute="ColorAdd_R">
                    <ChannelFunction Attribute="ColorAdd_R" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Offset="2" Highlight="255/1" Geometry="Body">
                <LogicalChannel Attribute="ColorAdd_G">
                    <ChannelFunction Attribute="ColorAdd_G" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Offset="3" Highlight="255/1" Geometry="Body">
                <LogicalChannel Attribute="ColorAdd_B">
                    <ChannelFunction Attribute="ColorAdd_B" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
        </DMXChannels>
        <Relations />
    </DMXMode>
<!--
Second Mode
 -->
    <DMXMode Name="Intensity + RGB Mode" Geometry="Body">
        <DMXChannels>
            <DMXChannel Offset="1" Highlight="255/1" Geometry="Body">
                <LogicalChannel Attribute="Dimmer" Master="Grand">
                    <ChannelFunction Attribute="Dimmer" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Offset="2" Default="255/1" Highlight="255/1" Geometry="Body">
                <LogicalChannel Attribute="ColorAdd_R">
                    <ChannelFunction Attribute="ColorAdd_R" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Offset="3" Default="255/1" Highlight="255/1" Geometry="Body">
                <LogicalChannel Attribute="ColorAdd_G">
                    <ChannelFunction Attribute="ColorAdd_G" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Offset="4" Default="255/1" Highlight="255/1" Geometry="Body">
                <LogicalChannel Attribute="ColorAdd_B">
                    <ChannelFunction Attribute="ColorAdd_B" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
        </DMXChannels>
        <Relations />
    </DMXMode>
<!--
Third Mode
 -->
    <DMXMode Name="Intensity + ColorMacro Mode" Geometry="Body">
        <DMXChannels>
            <DMXChannel Offset="1" Highlight="255/1" Geometry="Body">
                <LogicalChannel Attribute="Dimmer">
                    <ChannelFunction Attribute="Dimmer" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Offset="2" Highlight="0/1" Geometry="Body">
                <LogicalChannel Attribute="ColorMacro1">
                    <ChannelFunction Attribute="ColorMacro1" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
        </DMXChannels>
        <Relations />
    </DMXMode>
</DMXModes>
```