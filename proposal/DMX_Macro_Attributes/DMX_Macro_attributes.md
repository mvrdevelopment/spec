# DMX Macro attributes

## Linked Issue

https://github.com/mvrdevelopment/spec/issues/78

# Problem

The MacroDMX definitions are good for consoles to prepare UX interfaces (buttons) to trigger macros, but the console itself has no idea how to actually for example start a lamp (if this is based on a sequence or on a combination of channels). For this, adding (optional?) Fixture Type Attribute to the Macro would help.


# Solution

Add link from DMX Macro to a ChannelFunction

## Proposal

```xml
<FTMacros>
  <FTMacro Name="Lamp ON">
    <MacroDMX ChannelFunction="Head_Control1.Control1.Lamp Control 1" >
      <MacroDMXStep Duration="3.000000">
        <MacroDMXValue DMXChannel="Head_Control1" Value="135/1"/>
      </MacroDMXStep>
    </MacroDMX>
  </FTMacro>
  <FTMacro Name="Lamp OFF">
    <MacroDMX ChannelFunction="Head_Control1.Control1.Lamp Control 2" >
      <MacroDMXStep Duration="3.000000">
        <MacroDMXValue DMXChannel="Head_Control1" Value="235/1"/>
      </MacroDMXStep>
    </MacroDMX>
  </FTMacro>
</FTMacros>
```

### Changes to GDTF

Add an XML attribute `ChannelFunction` to `MacroDMX`

- Name: ChannelFunction.
- Value Type: Node
- Description: Link to channel function; Starting point DMX mode

