# Relation

Relations describe the dependencies between DMX channels and channel functions. Relations can be used to describe virtual attribute channels, for example. 
Virtual attributes can be added to a fixture by adding the attribute as normal but without giving the attribute relative DMX patch addresses in the XML attribute `Offset`. 
Virtual attributes are often dimmer attributes that act as virtual master intensity control in fixtures that do not have this attribute. It could be a LED fixture that only has Red `ColorAdd_R`, Green `ColorAdd_G`, and Blue `ColorAdd_B` attributes.

## Virtual Attributes

Example: Fixture type with three color attributes and a virtual dimmer.

If there is a virtual attribute, the type of the relation is "Multiply". Every channel function has to have one relation per DMX channel it is to affect.

Only the DMX channels that control the color have a relative DMX patch address. The DMX channel of the dimmer does not. Every relation has a Master and a Follower. The Master links to the DMX channel while the Follower links to the channel function.

In this example the Master links to the dimmer and the Follower links to the color channel functions.
Master is the "Name of the DMX channel"; Follower is "Name of the DMX channel.Name of the logical channel.Name of the channel function".

The name of the DMX channel is composed from the name of the linked geometry and the first logical channel.

Example: `Base_Dimmer`

The name of the logical channel is the name of its attribute.

The name of the channel function can be edited by the user. By default, the name is composed from the name of the Attribute and an enumerated count that depends on the index of the channel function.
Example:

- Dimmer 1
- Dimmer 2
- Strobe 3

Here, the Master is "Base_Dimmer"; the Follower is "Base_Dimmer.Dimmer.Dimmer 2"

```
<DMXModes>
    <DMXMode Name="Mode 1" Geometry="Body">
        <DMXChannels>
            <DMXChannel Offset="1" Default="255/1" Highlight="255/1" Geometry="Pixel">
                <LogicalChannel Attribute="ColorAdd_R" >
                    <ChannelFunction Attribute="ColorAdd_R" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Offset="2" Default="255/1" Highlight="255/1" Geometry="Pixel">
                <LogicalChannel Attribute="ColorAdd_G" >
                    <ChannelFunction Attribute="ColorAdd_G" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Offset="3" Default="255/1" Highlight="255/1" Geometry="Pixel">
                <LogicalChannel Attribute="ColorAdd_B" >
                    <ChannelFunction Attribute="ColorAdd_B" DMXFrom="0/255" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
            <DMXChannel Highlight="255/1" Geometry="Pixel">
                <LogicalChannel Attribute="Dimmer" >
                    <ChannelFunction Attribute="Dimmer" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" />
                </LogicalChannel>
            </DMXChannel>
        </DMXChannels>
        <Relations>
            <Relation Name="Virtual Dimmer R" Master="Pixel_Dimmer" Follower="Pixel_ColorAdd_R.ColorAdd_R.ColorAdd_R 1" Type="Multiply" />
            <Relation Name="Virtual Dimmer G" Master="Pixel_Dimmer" Follower="Pixel_ColorAdd_G.ColorAdd_G.ColorAdd_G 1" Type="Multiply" />
            <Relation Name="Virtual Dimmer B" Master="Pixel_Dimmer" Follower="Pixel_ColorAdd_B.ColorAdd_B.ColorAdd_B 1" Type="Multiply" />
        </Relations>
    </DMXMode>
</DMXModes>
```