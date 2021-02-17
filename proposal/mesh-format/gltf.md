# Support for GLTF 

## Linked Issue

 - Add additional 3D supported formats #8 https://github.com/mvrdevelopment/spec/issues/8 

# Problem

3DS File format is not an open file format and also very old. Moving to a new more modern file format should make it adopters much more easy to implement GDTF and MVR.

But also it is important to keep backword compatibility. 

# Solution

The we will allow GDTF and MVR to have glTF files https://github.com/KhronosGroup/glTF/blob/master/README.md as default mesh format.

The following requirements for the glTF file apply:

- Use the `glb` binary formart
- Only use the v2 formart
- Do not use extension
- Only use jpeg or png texture resource
- The normal alignment for 

### Changes to GDTF

To describe the device type, an uncompressed zip file with the extension
"\*.gdtf" is used. The archive shall contain a description XML file and
resource files. Some of the resource files are located in a folder
structure. There are two folders defined: "./wheels" and "./models". The
folder "./models" has trhee subfolders for a better structural overview
called "./models/3ds", "./models/glb" and "./models/svg". The description.xml file
contains the description of the device type and all DMX modes as well as
all firmware revisions of the device.

```
./description.xml
./thumbnail.png
./thumbnail.svg
./wheels/gobo1.png
./wheels/gobo2.png
./models/3ds/base.3ds
./models/glb/base.glb
./models/3ds/yoke.3ds
./models/glb/yoke.glb
./models/svg/base.svg
./models/svg/yoke.svg
```



| Attribute Name | Attribute Value Type                        | Description                          |
| -------------- | ------------------------------------------- | ------------------------------------ |
| File           | [Resource](#user-content-attrtype-resource) | Optional; File name without extension and without subfolder containing description of the model. Use the following as a resource file: - 3DS file to provide 3D model. |


- GLB file to provide 3D model.
- STEP file to provide 3D model as a parametric model;
- SVG file to provide the 2D symbol. 



### Changes MVR
