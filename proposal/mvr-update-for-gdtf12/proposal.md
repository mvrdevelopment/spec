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

## Proposal 3 - Default New MVR Object types Support and Electrical


## Proposal 4 - Default New MVR Object types Support and Electrical