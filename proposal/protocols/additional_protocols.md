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

Current system allows easy mapping of buffers with values (like DMX data) already. 

For command based protocols (OSC), we can use the existing Channel Function structure, where the OSC command is the name of the channel function, the value is the DMXFrom field. So this channel:

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

Is addressable via "Head_Dimmer.Dimmer.Dimmer"

For byte buffers protocols, mapping can be added:

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


```xml

<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<GDTF DataVersion="1.1">

  <FixtureType CanHaveChildren="Yes" Description="" FixtureTypeID="00000000-0000-0000-0000-000000000000" LongName="Basic Moving Head" Manufacturer="GDTF Template" Name="Basic Moving Head" RefFT="" ShortName="Moving Head" Thumbnail="">
    <DMXModes>
      <DMXMode Geometry="Base" Name="Default">
        <DMXChannels>
          <DMXChannel DMXBreak="1" Default="0/1" Geometry="Beam" Highlight="255/1" Offset="1" CustomName="Pipe_Pressure.Pressure.Pressure">
            <LogicalChannel Attribute="Dimmer" DMXChangeTimeLimit="0.000000" Master="Grand" MibFade="0.000000" Snap="No">
              <ChannelFunction Attribute="Dimmer" DMXFrom="0/1" Name="Dimmer 1" OriginalAttribute="" PhysicalFrom="0.000000" PhysicalTo="1.000000" RealAcceleration="0.000000" RealFade="0.000000">
              </ChannelFunction>
            </LogicalChannel>
          </DMXChannel>
          <DMXChannel DMXBreak="1" Default="32768/2" Geometry="Yoke" Highlight="None" Offset="2,3">
            <LogicalChannel Attribute="Pan" DMXChangeTimeLimit="0.000000" Master="None" MibFade="0.000000" Snap="No">
              <ChannelFunction Attribute="Pan" DMXFrom="0/2" Name="Pan 1" OriginalAttribute="" PhysicalFrom="-270.000000" PhysicalTo="270.000000" RealAcceleration="0.000000" RealFade="0.000000">
              </ChannelFunction>
            </LogicalChannel>
          </DMXChannel>
          <DMXChannel DMXBreak="1" Default="32768/2" Geometry="Head" Highlight="None" Offset="4,5">
            <LogicalChannel Attribute="Tilt" DMXChangeTimeLimit="0.000000" Master="None" MibFade="0.000000" Snap="No">
              <ChannelFunction Attribute="Tilt" DMXFrom="0/2" Name="Tilt 1" OriginalAttribute="" PhysicalFrom="-110.000000" PhysicalTo="110.000000" RealAcceleration="0.000000" RealFade="0.000000">
              </ChannelFunction>
            </LogicalChannel>
          </DMXChannel>
        </DMXChannels>
      </DMXMode>
    </DMXModes>
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
      <PosiStageNet>
        <Tracker>
            <ori_z type="in"> 
                <Link Mode="Default" Channels="2,3" Min="0" Max="65355" From="0" To="100"></Link>
            </ori_z>
            <pos_y type="in"> 
                <Link Mode="Default" ChannelFunction="Beam_Dimmer.Dimmer.Dimmer" Min="0" Max="100" From="0" To="100"></Link>
            </pos_x>
            <ori_y type="out"> 
                <Link Mode="Default" ChannelFunction="Beam_Dimmer.Dimmer.Dimmer" Min="0" Max="65355" From="0" To="100"></Link>
            </ori_y>
        </Tracker>
      </PosiStageNet>
      <OpenSoundControl>
      </OpenSoundControl>
      <CITP>
      </CITP>
    </Protocols>
    
  </FixtureType>

</GDTF>

```

## Proposal 1

### Changes to GDTF

- Describe the solution
- use \`\`\`xml \`\`\` to wrap xml examples

### Changes MVR

- describe the solution(s)
- use \`\`\`xml \`\`\` to wrap xml examples
