# Activation Groups

This section is used to define attribute groups which are to be used together. For example, Pan and Tilt attributes. If the device has these attributes in order to control the position, they have to be used together. Defining only one attribute does not guarantee that the device will be directed toward a specified position. Same applies for color mixing. All attributes of a color mixing system should ideally be grouped to an activation group. Another example could be grouping blades of a shaper unit. Find a list of predefined activation groups in the GDTF documentation in appendix B. 

The following example shows the activation grouping of a basic RGB led fixture. As the fixture only has three DMX channels to control the primary colors, only one activation group is needed. The activation groups have to be defined in the activation groups node. The child of the node is the activation group. 

```
 <ActivationGroups>
     <ActivationGroup Name="ColorRGB" />
 </ActivationGroups>
```

The link of an attribute to an activation group has to be defined in the attributes node. 

```
 <Attributes>
     <Attribute Name="ColorAdd_R" Pretty="R" ActivationGroup="ColorRGB" Feature="Color.RGB" PhysicalUnit="ColorComponent" Color="0.6401,0.33,21.26" />
     <Attribute Name="ColorAdd_G" Pretty="G" ActivationGroup="ColorRGB" Feature="Color.RGB" PhysicalUnit="ColorComponent" Color="0.3,0.6,71.52" />
     <Attribute Name="ColorAdd_B" Pretty="B" ActivationGroup="ColorRGB" Feature="Color.RGB" PhysicalUnit="ColorComponent" Color="0.15,0.06,7.22" />
 </Attributes>
```