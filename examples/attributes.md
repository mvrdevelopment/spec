# Attributes

Attributes are used to describe the different functionalities of a fixture type. Attributes are what is actually controlled. Attributes are organized to features. Every fixture has at least one attribute, but it can have several attributes. A generic dimmer fixture type typically has only one attribute – Dimmer – while an advanced moving light may have 30+ different attributes.<br>
Find the list of predefined attributes in appendix A of the GDTF specification. Also, you can create your own attributes. To keep the control of the fixture type as simple as possible – especially when using several fixture types at the same time – we recommend to use the predefined attributes. That is, create a new attribute if a function of the fixture type cannot be described using a predefined one.

Some of the attributes listed in appendix A are to be numbered consecutively. The numbering of those attributes is defined by the wildcards (n) and (m). (n) and (m) are independently of each other. Start the numbering with 1. For example Effects(n)Adjust(m) would be numbered Effects1Adjust1, Effects1Adjust2, Effects2Adjust1, Effects2Adjust2 and so on. 

## Example – Basic Moving Head

The first example shows the attributes used to describe the example of a basic moving head.<br>
Feature has to be given as "FeatureGroup.Feature". Feature groups and features that are used have to be defined in the feature groups section of the fixture type. Also, a physical unit can be given per attribute. The physical unit is necessary for control and visualization of the fixture type – for example to distinguish between an indexed gobo (rotation in degree) and a rotating gobo (angular speed in degree/s). Find the list of supported physical units in the documentation. 

```
            <Attributes>
                <Attribute Name="Dimmer" Pretty="Dim" Feature="Dimmer.Dimmer" PhysicalUnit="LuminousIntensity" />
                <Attribute Name="Pan" Pretty="P" ActivationGroup="PanTilt" Feature="Position.PanTilt" PhysicalUnit="Angle" />
                <Attribute Name="Tilt" Pretty="T" ActivationGroup="PanTilt" Feature="Position.PanTilt" PhysicalUnit="Angle" />
                <Attribute Name="Gobo1" Pretty="G1" ActivationGroup="Gobo" Feature="Gobo.Gobo" />
                <Attribute Name="Color1" Pretty="C1" ActivationGroup="ColorRGB" Feature="Color.Color" />
            </Attributes>
```

## Example – More Complex Fixture Type

The second example shows the attributes of a moving light with multiple other functions. That is, there are more attributes depending on the fixture type. In this example several attributes have a link to a "MainAttribute". In this example there are three attributes used to describe the different functionalities of the Shutter (Shutter1, Shutter1Strobe and Shutter1StrobeRandom). As these three functionalities are logically exclusive (that means that the shutter of a fixture can not be open and strobing at the same time), they are linked together. One of them is the MainAttribute. In this example this is the attribute "Shutter1", while the other two attributes have a link to this MainAttribute. Many attributes stand for their own and do not have related attributes that link to them as a mainattribute. 

```
<Attributes>
    <Attribute Name="Shutter1" Pretty="Sh1" Feature="Beam.Beam" />
    <Attribute Name="Shutter1Strobe" Pretty="Strobe" MainAttribute="Shutter1" Feature="Beam.Beam" PhysicalUnit="Frequency" />
    <Attribute Name="Shutter1StrobeRandom" Pretty="Random" MainAttribute="Shutter1" Feature="Beam.Beam" PhysicalUnit="Frequency" />
    <Attribute Name="Dimmer" Pretty="Dim" Feature="Dimmer.Dimmer" PhysicalUnit="LuminousIntensity" />
    <Attribute Name="ColorAdd_R" Pretty="R" ActivationGroup="ColorRGB" Feature="Color.RGB" PhysicalUnit="ColorComponent" Color="0.64,0.33,21.3" />
    <Attribute Name="ColorAdd_G" Pretty="G" ActivationGroup="ColorRGB" Feature="Color.RGB" PhysicalUnit="ColorComponent" Color="0.3,0.6,71.5" />
    <Attribute Name="ColorAdd_B" Pretty="B" ActivationGroup="ColorRGB" Feature="Color.RGB" PhysicalUnit="ColorComponent" Color="0.15,0.06,7.2" />
    <Attribute Name="Color1" Pretty="C1" ActivationGroup="ColorRGB" Feature="Color.Color" />
    <Attribute Name="Color1WheelSpin" Pretty="Wheel Spin" MainAttribute="Color1" ActivationGroup="ColorRGB" Feature="Color.Color" PhysicalUnit="AngularSpeed" />
    <Attribute Name="Gobo1" Pretty="G1" ActivationGroup="Gobo" Feature="Gobo.Gobo" />
    <Attribute Name="Gobo1WheelSpin" Pretty="Wheel Spin" MainAttribute="Gobo1" ActivationGroup="Gobo" Feature="Gobo.Gobo" PhysicalUnit="AngularSpeed" />
    <Attribute Name="Gobo1Pos" Pretty="G1 &lt;&gt;" Feature="Gobo.Gobo" PhysicalUnit="Angle" />
    <Attribute Name="Gobo1PosRotate" Pretty="Rotate" MainAttribute="Gobo1Pos" Feature="Gobo.Gobo" PhysicalUnit="AngularSpeed" />
    <Attribute Name="Gobo2" Pretty="G2" ActivationGroup="Gobo" Feature="Gobo.Gobo" />
    <Attribute Name="Gobo2WheelSpin" Pretty="Wheel Spin" MainAttribute="Gobo2" ActivationGroup="Gobo" Feature="Gobo.Gobo" PhysicalUnit="AngularSpeed" />
    <Attribute Name="Prism1" Pretty="Prism1" ActivationGroup="Prism" Feature="Beam.Beam" />
    <Attribute Name="Iris" Pretty="Iris" Feature="Beam.Beam" />
    <Attribute Name="IrisStrobe" Pretty="Strobe" MainAttribute="Iris" Feature="Beam.Beam" PhysicalUnit="Frequency" />
    <Attribute Name="Zoom" Pretty="Zoom" Feature="Focus.Focus" PhysicalUnit="Angle" />
    <Attribute Name="Focus1" Pretty="Focus1" Feature="Focus.Focus" />
    <Attribute Name="Pan" Pretty="P" ActivationGroup="PanTilt" Feature="Position.PanTilt" PhysicalUnit="Angle" />
    <Attribute Name="Tilt" Pretty="T" ActivationGroup="PanTilt" Feature="Position.PanTilt" PhysicalUnit="Angle" />
    <Attribute Name="Control1" Pretty="Ctrl1" Feature="Control.Control" />
    <Attribute Name="Effects1" Pretty="FX1" Feature="Beam.Beam" />
    <Attribute Name="Effects1Rate" Pretty="FX1 Rate" Feature="Beam.Beam" PhysicalUnit="Speed" />
    <Attribute Name="Effects2" Pretty="FX2" Feature="Beam.Beam" />
    <Attribute Name="Effects2Rate" Pretty="FX2 Rate" Feature="Beam.Beam" PhysicalUnit="Speed" />
    <Attribute Name="EffectsSync" Pretty="FX Sync" Feature="Beam.Beam" />
</Attributes>
```