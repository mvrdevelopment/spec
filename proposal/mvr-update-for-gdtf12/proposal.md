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
    <Matrix>{0.158127,-0.987419,0.000000}{0.987419,0.158127,0.000000}{0.000000,0.000000,1.000000}{6020.939200,2838.588955,4978.134459}</Matrix>
    <GDTFSpec>Custom@Robe Robin MMX WashBeam</GDTFSpec>
    <GDTFMode>DMX Mode</GDTFMode>
    <Focus>4A B1 94 62 A6 E3 4C 3B B2 5A D8 09 9F 78 17 0C</Focus>
    <Position>77 BC DE 16 95 A6 47 25 9D 04 16 A0 BD 67 CD 1A</Position>
    <Addresses>
        <Address break="0">45</Address>
    </Addresses>
    <CustomCommands>
        <CustomCommand>Body_Pan,f 50</CustomCommand>
        <CustomCommand>Yoke_Tilt,f 50</CustomCommand>
    </CustomCommands>
    <Mappings>
    </Mappings>
    <FixtureID></FixtureID>
    <UnitNumber>0</UnitNumber>
    <FixtureTypeId>0</FixtureTypeId>
    <CustomId>0</CustomId>
    <Color>{2.533316,-5.175210,3.699302}</Color>
    <Gobo rotation="32.5">image_file_forgobo</Gobo>
</Fixture>
```


