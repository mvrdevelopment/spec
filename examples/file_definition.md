# File Definition

To describe the device type, use an uncompressed zip file with the file extension "*.gdtf". The archive contains the file description.xml (with the description of the device type and all DMX modes of this device) and additional resource files. Some of the resource files are located in a folder structure. Use UTF-8 to encode the xml file. Specify the name of the file as follows:

```
<ManufacturerName>@<FixtureTypeName>@<OptionalComment>
```

Example: generic@led.gdtf

Additional resource files can be images (e.g., gobo, thumbnail picture of the fixture) and 2D/3D files (e.g., 3D models or 2D symbols).

The folder structure of a typical GDTF file would look like this: 
```
./description.xml 
./thumbnail.png 
./thumbnail.svg 
./wheels/gobo1.png 
./wheels/gobo2.png 
./models/3ds/base.3ds 
./models/3ds/yoke.3ds 
./models/svg/base.svg 
./models/svg/yoke.svg
```