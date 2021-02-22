# Support for GLTF 

## Linked Issue

 - Add additional 3D supported formats [#8](https://github.com/mvrdevelopment/spec/issues/8 )

# Problem

3DS File format is not an open file format and also very old. Moving to a new more modern file format should make it adopters much more easy to implement GDTF and MVR.

But also it is important to keep backword compatibility. 

# Solution

The we will allow GDTF and MVR to have [glTF files](https://github.com/KhronosGroup/glTF/blob/master/README.md) as default mesh format.

The following requirements for the glTF file apply:

- Use the `glb` binary formart
- Only use the v2 format
- Do not use extension
- Do not use animations
- Only use jpeg or png texture resource
- The GDTF defined alignment for placing objects in the scene
- all vertex attributes are `GL_FLOAT`

Note that MVR and GDTF compatible application need to *read* `glTF` and `3ds` files, but only need to export either `glTF` or `3ds`.

## Changes to GDTF

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
| File           | [Resource](#user-content-attrtype-resource) | Optional; File name without extension and without subfolder containing description of the model. Use the following as a resource file: - 3DS or GLB file to provide 3D model. |


- GLB file to provide 3D model.
- STEP file to provide 3D model as a parametric model;
- SVG file to provide the 2D symbol. 


## Changes MVR

Example of a typical MVR archive:

```
GeneralSceneDescription.xml
Custom@Fixture.gdtf
Custom@Fixture.gdtf
geo1.3ds
geo1.glb
Textr12.png
```

## Node Definition: Geometry3D

Node name: `Geometry3D`

| Attribute Name | Attribute Value Type                        | Default Value when Optional | Description                                                                                                                                  |
| -------------- | ------------------------------------------- | --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| fileName       | [FileName](#user-content-attrtype-filename) | Not Optional                | The file name, including extension, of the external file in the archive. If there is no extension, it will assume that the extension is 3ds. |

## Best Practices

### Asset Authoring Flow
The Khronos Group has a good example of a glTF authoring flow.
https://www.khronos.org/blog/art-pipeline-for-gltf

### Sample files
These samples files are good for testing
https://github.com/KhronosGroup/glTF-Sample-Models/tree/master/2.0

The sample viewer can be used as reference
http://github.khronos.org/glTF-Sample-Viewer/