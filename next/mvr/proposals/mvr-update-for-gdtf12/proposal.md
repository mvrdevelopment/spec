# Support for GDTF 1.2 in MVR and general update

## Linked Issue

https://github.com/mvrdevelopment/spec/issues/100
https://github.com/mvrdevelopment/spec/issues/94
https://github.com/mvrdevelopment/spec/issues/70

# Problem

We need to update the MVR Spec so that it takes advantage of the new features of GDTF 1.2.

In addition, we want to give the option to express:
- Custom Gobos
- Custom Filters
- Custom Pan and Tilt Values


# Solution


## General information

By  default, the GDTF defintion will be brought to more objects. We still give the option to defines object via the geometry nodes, but also add the option to define an object via GDTF.

GDTF 1.2 ( DIN SPEC 15800:2022 ) we have added support for more object types. We now support trusses, hoists, lasers an hoist directly in GDTF. As GDTF uses a component based system with the geometry concept, one object could adopt multiple options.
So when you have a Hoist with a power outlet, you can model the supporting functionality with the Support Geometry and the power functionality with the electrical geometry. Same applies for structures that have a power outlet.

All of this different object types still will have their XML-Node Node like Truss, Laser, SceneObject etc, but the actual behavior of the object is more defined by the GDTF.

## Proposal 1 - Channel Function Definitions in MVR

You can use a Custom Commands for Channel Function like we defined them for OSC to define the state of the fixture. 
This lets the user define custom Pan and Tilt values for fixtures based on percentage or physical values.

This also applies to all other control. So you can transfer the value for Focus, Strobe etc.

```xml
<Fixture name="Fixture With Pan And Tilt Values" uuid="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6">
    ...
    <CustomCommands>
        <CustomCommand>Body_Pan,f 50</CustomCommand>
        <CustomCommand>Yoke_Tilt,f 50</CustomCommand>
    </CustomCommands>
</Fixture>
```

## Proposal 2 - Default GDTF Container for MVR

We will add a default GDTF that acts as a resource container for the MVR file. 
This Files holds custom filters, gobos and emitter data that can be used to overwrite individual GDTF definitions.

You can define the map of replacement based on the objects that the target GDTF has. If you want to define a static gobo or color filter, don't define a target.

```xml
<Fixture name="Fixtures with Overwrite" uuid="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6">
   ...
   <Overwrites>
   <!--Overwrites for real existing objects in the GDTF-->
    <Overwrite universal="Universal Emitter 1">Emitter 1</Overwrite>
    <Overwrite universal="Universal Filter 1">Filter 1</Overwrite>
    <Overwrite universal="Universal Wheel 1.Universal Wheel Slot 1">Wheel 1.Wheel Slot 1</Overwrite>
    <!--Overwrites for non existing objects in the GDTF.-->
    <Overwrite universal="Universal Wheel 1.Universal Wheel Slot 2"/>
   </Overwrites>
</Fixture>
```

## Proposal 3 - Default New MVR Object types Electrical
```xml
<SceneObject name="Fixtures with Overwrite" uuid="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6">
   ...
   <GDTFSpec>Plugbox HAN 16</GDTFSpec>
   <GDTFMode>Default</GDTFMode>
   <Connections>    
     <Connection own="Input" toObject="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6" other="Output1"/>
     <Connection own="1" toObject="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6" other="IN"/>
     <Connection own="2" toObject="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6" other="IN"/>
   </Connections>
</SceneObject>
```

## Proposal 4 - Default New MVR Object types Truss
```xml
<Truss name="Fixtures with Overwrite" uuid="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6">
   ...
   <GDTFSpec>Prolyte H30V 200</GDTFSpec>
   <GDTFMode>Default</GDTFMode>
</Fixture>
```


## Proposal 4 - Default New MVR Object types Support
```xml
<Support name="Fixtures with Overwrite" uuid="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6">
   ...
   <GDTFSpec>D8 500Kg</GDTFSpec>
   <GDTFMode>Default</GDTFMode>
   <ChainLength>5000</ChainLength>
</Fixture>
```


## Proposal 5 - Universal Fixture


You can add a default GDTF what can be used as a resource container to the MVR. It will have the extension `gdtt` (*General Device Type Template*) and the name:

```
Universal.gdtt
```

You can only add one template file the to one MVR.