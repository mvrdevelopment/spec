# Settings object

**Problem:** personality settings in the fixture redefine physical behavior -
style of mixing, movement speed, movement ranges, direction and so on. This is
currently not possible to describe via GDTF.

Ref: [#38](https://github.com/mvrdevelopment/spec/issues/38)

**Proposal: **Introduce a Settings object. Settings could be linked to from a
ChannelFunction, to enable it's function and could be get/set via RDM. This can
solve an issue of physical attributes defined by or linked via
ChannelFunctions.

Settings would be DMX Mode specific collect and would define a Setting.

Setting would have attributes...

- Name
- Default value
- RDM PID
- ...

...and would contain a SettingValues collect, where a SettingValue would have a
attributes:

- Type (e.g uint8)

...and would contain Values, a Value would have attributes:

- Value
- Label
- ...

This is the simplest definition. Potentially, value can be in a range e.g.
0-65535, then allow to define a range then all single points. We could look at
RDM parameters to be compatible.

#### Pseudo XML example:

```
Settings
  Setting Name: PanRange, Default: 0, PID: 0x0xx
    SettingValues
      SettingValue, Type: Uint8:
        Value: Value: 0, Label: Normal
        Value: Value: 1, Label: Extended
```
#### Usage:

- ChannelFunction could either reuse ModeMaster or introduce a SettingsMaster,
  which would point to a Setting, to enable a particular ChannelFunction
- Setting could send out RDM and set a value.
- Setting could be set from RDM after get value.

#### Use case, examples:

- RGBW or CMY or xxx color mixing
- Pan/Tilt ranges with/without Accessories (TopHat)
- Pan/Tilt invert
- Dimmer curve
- Different LEDs (but not a lamp)
- ...

#### Current solution in GDTF 1.2:

- Not possible to describe
- A possible workaround: Create a dedicated DMX Mode (Mode 1 Standard RGBW,
  Mode 1 Standard CMY) for most critical things (color mixing).

#### This proposal solves:

- Physical attributes that are set by Channel Functions

#### This proposal solves but is cumbersome:

- Physical values where SettingsValue is a PhysicalFrom/To value, thus setting
  for example Pan/Tilt speed to time 0-255 would require 255 Channel Functions.

#### This proposal does not solve:

- Physical attributes defined by geometries
