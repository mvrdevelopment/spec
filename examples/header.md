# Header

Every xml document has to start with the xml description node. This node contains the xml declaration and sets the character encoding. In GDTF the character encoding has to be set to `UTF-8`.

xml node:
```
<xml version="1.0" encoding="UTF-8">
```

The second node is the GDTF node which has the data version of the GDTF as an attribute. The data version defines the minimal version of compatibility. The version format is `Major.Minor`.

GDTF node:
```
<GDTF DataVersion="1.1">
Fixture type node: 
     <FixtureType Name="Basic moving head" ShortName="BMH" LongName="Moving head with basic functionality" Description="This is a very simple moving head that only has basic features" Manufacturer="GDTF example" FixtureTypeID="00000000-9D13-0000-C92D-C1C76F583F46" Thumbnail="picture_fixture.png">
     </FixtureType>
 </GDTF>
 ```

The fixture type node is the staring point of the description of the fixture type in the xml file. FixtureTypeID is a GUID. Find generators for the creation of a GUID on the internet.<br>

## Fixture Type Node → Name, ShortName, LongName

* ''Name'' - Is safe for parsing as it is based on Name → restrictedLiteral
* ''ShortName'' - short, non detailed version of fixture name, can be an abbreviation. Can use any characters or symbols. 
* ''LongName'' - full, complete name of fixture, can include any characters, extra symbols.
