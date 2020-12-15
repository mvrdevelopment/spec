# FeatureGroups

This section is used to define the logical grouping of attributes. For example, Pan and Tilt attributes are to be grouped together in the feature "PanTilt" and in the feature group "Position". The feature group "Position" also contains the feature XYZ. The attributes X, Y, and Z  are grouped here. A list of predefined features and feature groups can be found in the GDTF documentation in appendix B. Additional feature groups and features can be added. To keep the fixture type easy to control – especially when using several fixture types at the same time – we recommend to only add features and feature groups if a function of a fixture type cannot be described by using the predefined ones.

# Example - Basic Moving Head

The first example shows the feature groups of the example fixture type "Basic Moving Head".

This fixture type has a simple feature grouping:
- Feature "Dimmer" -> Feature Group "Dimmer"
- Feature "PanTilt" -> Feature Group "Position"
- Feature "Gobo" -> Feature Group "Gobo"
- Feature "Color" -> Feature Group "Color"

```
<FeatureGroups>
    <FeatureGroup Name="Dimmer">
        <Feature Name="Dimmer" />
    </FeatureGroup>
    <FeatureGroup Name="Position">
        <Feature Name="PanTilt" />
    </FeatureGroup>
    <FeatureGroup Name="Gobo">
        <Feature Name="Gobo" />
    </FeatureGroup>
    <FeatureGroup Name="Color">
        <Feature Name="Color" />
    </FeatureGroup>
</FeatureGroups>
```

## Example - More Complex Fixture Type

A more complex fixture type with numerous attributes could have a feature grouping as follows:
```
<FeatureGroups>
    <FeatureGroup Name="Color">
        <Feature Name="RGB" />
        <Feature Name="Color" />
    </FeatureGroup>
    <FeatureGroup Name="Beam">
        <Feature Name="Beam" />
    </FeatureGroup>
    <FeatureGroup Name="Dimmer">
        <Feature Name="Dimmer" />
    </FeatureGroup>
    <FeatureGroup Name="Gobo">
        <Feature Name="Gobo" />
    </FeatureGroup>
    <FeatureGroup Name="Focus">
        <Feature Name="Focus" />
    </FeatureGroup>
    <FeatureGroup Name="Position">
        <Feature Name="PanTilt" />
    </FeatureGroup>
    <FeatureGroup Name="Control">
        <Feature Name="Control" />
    </FeatureGroup>
    <FeatureGroup Name="Shapers">
        <Feature Name="Shapers" />
    </FeatureGroup>
</FeatureGroups>
```