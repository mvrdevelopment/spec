# Additional protocols support

## Linked Issue

https://github.com/mvrdevelopment/spec/issues/74

# Problem

We need to be able to describe a way to control a device via other protocols like Open Sound Control or Dynalite.

Open Sound Control (OSC)

- https://en.wikipedia.org/wiki/Open_Sound_Control
- http://opensoundcontrol.org/

Dynalite (DyNET)

- https://en.wikipedia.org/wiki/Dynalite#Communications
- https://www.dynalite.org/download-library/technical-engineering-notes/

PosiStageNet

- https://www.posistage.net/


# Solution

Current GDTF system allows very easy mapping of buffers with values (like DMX data), because GDTF has a well defined data model and a way of addressing a particular feature/effect/function via ChannelFunctions. The data is then provided as a value into the DMXFrom field - we can easily imagine that the "DMXFrom=value" is a "Data=value". So the only thing that needs to be done is to align the daẗa addressing to the channel functions and the data payload to the DMXFrom fields. There are multiple ways how this mapping can be done:

- define the mapping in an external file/documentation
- define the mapping for each protocol data mapping as a defined section in the GDTF Spec
- define a way in GDTF which would allow to define this mapping

Fixture addressing: fixture addressing might or might not be part of this specification, depending on the particular requirement.

Do note, that we do not defining the details of each protocol  itself, we only define how their data models are mapped.

## Proposal 1 - define mapping in an external file/documentation and use GDTF as is

The external file might be machine readable or in the form of a documentation. Generally, it contains a description of how the mapping is done. 

### Example for Open Sound Control:

Use the existing Channel Function structure, where the OSC addressing command name is the name of the channel function being addresses, the data payload value is the DMXFrom field. Where the OSC uses delimiter "/" to split each addressable part, the GDTF node delimiter "." can be used and then replaced to "/" during transmission.

So this channel:

 ```xml
   <DMXChannel DMXBreak="1" Geometry="Head" Highlight="65535/2" InitialFunction="Head_Dimmer.Dimmer.Dimmer" Offset="">
    <LogicalChannel Attribute="Dimmer" DMXChangeTimeLimit="0.000000" Master="Grand" MibFade="0.000000" Snap="No">
      <ChannelFunction Attribute="Dimmer" DMXFrom="0/2" Default="0/2" Name="Dimmer" OriginalAttribute="Dimmer intensity" PhysicalFrom="0.000000" PhysicalTo="1.000000" RealAcceleration="0.000000" RealFade="0.000000">
        <ChannelSet DMXFrom="0/2" Name="Closed" WheelSlotIndex="0"/>
        <ChannelSet DMXFrom="1/2" Name="" WheelSlotIndex="0"/>
        <ChannelSet DMXFrom="65535/2" Name="Open" WheelSlotIndex="0"/>
      </ChannelFunction>
    </LogicalChannel>
  </DMXChannel>
```

Is addressable via "Head_Dimmer.Dimmer.Dimmer" and "Head_Dimmer/Dimmer/Dimmer" respectively. Fixture individual address is a field defined in the fixture, in case of a simple DMX address, this could look like this: "1/Head_Dimmer/Dimmer/Dimmer".

### For other byte buffers protocols, mapping can be added:

 ```xml
    <Protocols>
      <Art-Net>
        <Map key="0">0</>
        <Map key="1">1</>
        <Map key="2">2</>
      </Art-Net>
      <sACN>
        <Map key="0">0</>
        <Map key="1">1</>
        <Map key="2">2</>
      </Art-Net>
    </Protocols>
 ```

### RS232 Communication Protocol example

In some cases, we might like to link a particular protocol command to a GDTF ChannelFunction, other parts of the definition (for example Geometry) can be used for sub-addressing, take this example of a RS232 Communication Protocol bases control (detailed definition in [this issue](https://github.com/mvrdevelopment/spec/issues/74):

Type 1: Selection of the preset colors:

  ```xml
      <DMXChannel DMXBreak="1" Geometry="Zone1" Highlight="255/1" InitialFunction="Zone1_ColorAdd_R.ColorAdd_R.ColorAdd_R 1" Offset="1">
        <LogicalChannel Attribute="ColorAdd_R" DMXChangeTimeLimit="0.000000" Master="None" MibFade="0.000000" Snap="No">
          <ChannelFunction Attribute="ColorAdd_R" DMXFrom="0/1" Default="255/1" Name="ColorAdd_R 1" OriginalAttribute="" PhysicalFrom="0.000000" PhysicalTo="1.000000" RealAcceleration="0.000000" RealFade="0.000000"/>
        </LogicalChannel>
      </DMXChannel>
  ```


 ```xml
 <Commands_to_ChannelFunctions>
  <command key="red"      attribute="Zone1_ColorAdd_R.ColorAdd_R.ColorAdd_R">  
  <command key="green"    attribute="Zone1_ColorAdd_G.ColorAdd_G.ColorAdd_G">  
  <command key="blue"     attribute="Zone1_ColorAdd_B.ColorAdd_B.ColorAdd_B">  
  <command key="white"    attribute="Zone1_ColorAdd_W.ColorAdd_W.ColorAdd_W"> 
  <command key="yellow"   attribute="Zone1_ColorAdd_Y.ColorAdd_R.ColorAdd_Y"> 
  <command key="cyan"     attribute="Zone1_ColorAdd_C.ColorAdd_G.ColorAdd_C"> 
  <command key="magenta"  attribute="Zone1_ColorAdd_M.ColorAdd_B.ColorAdd_M"> 
  <command key="blackout" attribute="Zone1_Dimmer.Dimmer.Dimmer"> 
 </Commands_to_ChannelFunctions>
 ```

`zone 1 green;`

Type 2, 3: Color mixing-RGB/W

This is based on how the attributes are ordered in the RS232 string, one could use the "Offset" as a byte/string offset:

  ```xml
      <DMXChannel DMXBreak="1" Geometry="Zone1" Highlight="255/1" InitialFunction="Zone1_ColorAdd_R.ColorAdd_R.ColorAdd_R" Offset="1">
        ...
      </DMXChannel>
      <DMXChannel DMXBreak="1" Geometry="Zone1" Highlight="255/1" InitialFunction="Zone1_ColorAdd_G.ColorAdd_G.ColorAdd_G" Offset="2">
        ...
      </DMXChannel>
      <DMXChannel DMXBreak="1" Geometry="Zone1" Highlight="255/1" InitialFunction="Zone1_ColorAdd_B.ColorAdd_B.ColorAdd_B" Offset="3">
        ...
      </DMXChannel>
      <DMXChannel DMXBreak="1" Geometry="Zone1" Highlight="None" InitialFunction="Zone1_ColorAdd_W.ColorAdd_W.ColorAdd_W" Offset="4">
        ...
      </DMXChannel>
  ```
`zone 1 5,18,28,148;`

### Dynalite example:

This is a DyNet channel to attribute mapping:

 ```xml
 <Commands_to_ChannelFunctions>
  <command key="80"      attribute="Zone1_ColorAdd_R.ColorAdd_R.ColorAdd_R">  
  <command key="81"    attribute="Zone1_ColorAdd_G.ColorAdd_G.ColorAdd_G">  
  <command key="82"     attribute="Zone1_ColorAdd_B.ColorAdd_B.ColorAdd_B">  
  <command key="83"    attribute="Zone1_ColorAdd_W.ColorAdd_W.ColorAdd_W"> 
 </Commands_to_ChannelFunctions>
 ```

See the [protocols.xml](./protocols.xml) for more examples.


## Proposal 1

### Changes to GDTF

- Describe the solution
- use \`\`\`xml \`\`\` to wrap xml examples

### Changes MVR

- describe the solution(s)
- use \`\`\`xml \`\`\` to wrap xml examples
