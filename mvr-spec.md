# MVR Version: 1.5 - draft 2

In the entertainment industry, the MVR file format allows programs to
share data and geometry for a scene. A scene is a set of parametric
objects such as fixtures, trusses, video screens, and other objects that
are used in the entertainment industry.

All objects used have a persistent unique ID to track changes between
the exchanging programs.

## Typical workflow

1.  Program A saves an MVR file containing a scene;
2.  Program B imports this file;
3.  Program B changes some parametric data in the scene;
4.  Program B saves an MVR containing the scene;
5.  Program A imports this file and applies the changes to the existing
    objects.

Vectorworks provide a [portable
library](MVR_portable_library) for convenience. This library
helps to read and write MVR files. This allows easy implementation of
the MVR file format.

## Definition

The file is an uncompressed ZIP archive file containing a set of files.
The files are stored in the root level within the archive without using
nesting folders. There must be at least one root file and a set of other
files. Their meaning is defined by the root file or other files that the
root file defines. The file name of the ZIP archive can be chosen
freely. The extension is:

`*.mvr`

Example of a typical MVR archive:

```
GeneralSceneDescription.xml
Custom@Fixture.gdtf
Custom@Fixture.gdtf
geo1.3ds
geo1.glb
Textr12.png
```

It is not allowed to create folders in this structure.

## Root File Definition

The name of the file is: `GeneralSceneDescription.xml`

The root file is an XML file with root node named:
`GeneralSceneDescription`

| Attribute Name | Attribute Value Type                      | Default Value when Optional | Description                                                         |
| -------------- | ----------------------------------------- | --------------------------- | ------------------------------------------------------------------- |
| verMajor       | [Integer](#user-content-attrtype-integer) | Not Optional                | Denotes the major version of the format used when saving this file. |
| verMinor       | [Integer](#user-content-attrtype-integer) | Not Optional                | Denotes the minor version of the format used when saving this file. |

| Child Node | Allowed Count | Description                                    |
| ---------- | ------------- | ---------------------------------------------- |
| UserData   | 0 or 1        | Specifies user data associated with this file. |
| Scene      | 1             | Defines the scene described in this file.      |

Find a complete example of a file [here
](Sample_GeneralSceneDescription).

# Node Definition: UserData

This node contains a collection of user data nodes defined and used by
provider applications if required.

Node name: `UserData`

| Child Node                    | Allowed Count | Description                   |
| ----------------------------- | ------------- | ----------------------------- |
| [Data](#node-definition-data) | 0 or many     | Defines a block of user data. |

## Node Definition: Data

This node contains a collection of data specified by the provider
application.

Node name: `Data`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                                                               |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------------------------------------------- |
| provider       | [String](#user-content-attrtype-string) | Not Optional                | Specifies the name of the provider application that created this data.    |
| ver            | [String](#user-content-attrtype-string) | 1                           | Version information of the data as specified by the provider application. |

# Node Definition: Scene

This node contains information about the scene.

Node name: `Scene`

| Child Node                          | Allowed Count | Description                           |
| ----------------------------------- | ------------- | ------------------------------------- |
| [AUXData](#node-definition-auxdata) | 0 or 1        | Defines auxiliary data for the scene. |
| [Layers](#node-definition-layers)   | 1             | A list of layers in the scene.        |

## Node Definition: AUXData

This node contains auxiliary data for the scene node.

Node name: `AUXData`

| Child Node                                              | Allowed Count | Description                                                    |
| ------------------------------------------------------- | ------------- | -------------------------------------------------------------- |
| [Symdef](#node-definition-symdef)                       | 0 or any      | Graphical representation that will be instanced in the scene.  |
| [Position](#node-definition-position)                   | 0 or any      | Defines a logical group of lighting devices.                   |
| [MappingDefinition](#node-definition-mappingdefinition) | 0 or any      | Defines a input source for fixture color mapping applications. |

### Node Definition: Symdef

This node contains the graphics so the scene can refer to this, thus
optimizing repetition of the geometry. The child objects are located
within a local coordinate system.

Node name: `Symdef`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](user-content-attrtype-uuid)      | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object               |

The child list contains a list of the following nodes:

| Child Node                                | Description                                                          |
| ----------------------------------------- | -------------------------------------------------------------------- |
| [Geometry3D](#node-definition-geometry3d) | The geometry of this definition that will be instanced in the scene. |
| [Symbol](#node-definition-symbol)         | The symbol instance that will provide a geometry of this definition. |

### Node Definition: Position

This node defines a logical grouping of lighting devices and trusses.

Node name: `Position`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object               |

### Node Definition: MappingDefinition

This node specified a input source for fixture color mapping
applications.

Node name: `MappingDefinition`

| Attribute Name | Attribute Value Type                | Default Value when Optional | Description                             |
| -------------- | ----------------------------------- | --------------------------- | --------------------------------------- |
| uuid           | [UUID](#user-content-attrtype-uuid) | Not Optional                | The unique identifier of the object.    |
| name           | [name](#attrType-Name)              |                             | The name of the source for the mapping. |

| Child Node                                        | Allowed Count | Description                                         |
| ------------------------------------------------- | ------------- | --------------------------------------------------- |
| [SizeX](#node-definition-sizex)                   | 1             | The size in x direction in pixels of the source.    |
| [SizeY](#node-definition-sizey)                   | 1             | The size in x direction in pixels of the source.    |
| [Source](#node-definition-source)                 | 1             | The video source that will be used for the Mapping. |
| [ScaleHandeling](#node-definition-scalehandeling) | 0 or 1        | How the source will be scaled to the mapping.       |

```xml
<MappingDefinition name="MappingStyle for View 1" uuid="BEF95EB8-98AC-4217-B10D-FB4B83381398">
    <SizeX>1920</SizeX>
    <SizeY>1080</SizeY>
   movie.mov
    
    <ScaleHandeling>UpScale</ScaleHandeling>
</MappingDefinition>
```

## Node Definition: Layers

This node defines a list of layers inside the scene. The layer is a
container of graphical objects defining a local coordinate system.

Node name: `Layers`

The child list contains a list of layer nodes:

| Child Node                      | Description             |
| ------------------------------- | ----------------------- |
| [Layer](#node-definition-layer) | A layer representation. |

### Node Definition: Layer

This node defines a layer. The layer is a spatial representation of a
geometric container. The child objects are located inside a local
coordinate system.

Node name: `Layer`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object               |

| Child Node                              | Allowed Count | Description                                                                                                                                                                                                                                                                      |
| --------------------------------------- | ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix)       | 0 or 1        | The transformation matrix that defines the location and orientation of this the layer inside its global coordinate space. This effectively defines local coordinate space for the objects inside. The Matrix of the Layer is only allowed to have an elevation, but no rotation. |
| [ChildList](#node-definition-childlist) | 1             | A list of graphic objects that are part of the layer.                                                                                                                                                                                                                            |

# Node Definition for Parametric Objects

## Node Definition: SceneObject

This node defines a generic graphical object.

Node name: `SceneObject`

| Attribute Name | Attribute Value Type                  | Default Value when Optional | Description                          |
| -------------- | ------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)   | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-name) | Empty                       | The name of the object               |

| Child Node                                | Allowed Count | Description                                                               |
| ----------------------------------------- | ------------- | ------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix)         | 0 or 1        | The location and orientation of the object inside the parent coordinate system.           |
| [Geometries](#node-definition-geometries) | 1             | A list of geometrical representation objects that are part of the object. |

## Node Definition: GroupObject

This node defines logical group of objects. The child objects are
located inside a local coordinate system.

Node name: `GroupObject`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object               |

| Child Node                              | Allowed Count | Description                                                     |
| --------------------------------------- | ------------- | --------------------------------------------------------------- |
| [Matrix](#node-definition-matrix)       | 0 or 1        | The location and orientation of the object inside the parent coordinate system. |
| [ChildList](#node-definition-childlist) | 1             | A list of graphic objects that are part of the group.           |

## Node Definition: FocusPoint

This node defines a focus point object.

Node name: `FocusPoint`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object               |

| Child Node                                | Allowed Count | Description                                                               |
| ----------------------------------------- | ------------- | ------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix)         | 0 or 1        | The location and orientation of the object inside the parent coordinate system.           |
| [Geometries](#node-definition-geometries) | 1             | A list of geometrical representation objects that are part of the object. |

## Node Definition: Fixture

This node defines a light fixture object.

Node name: `Fixture`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object               |

| Child Node                              | Allowed Count | Value Type                                   | Description                                                                                                                                   |
| --------------------------------------- | ------------- | -------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix)       | 0 or 1        |                                              | The location of the object inside the parent coordinate system.                                                                               |
| GDTFSpec                                | 1             | [FileName](#user-content-attrtype-filename)  | The name of the file containing the GDTF information for this light fixture.                                                                  |
| GDTFMode                                | 1             | [String](#user-content-attrtype-string)      | The name of the used DMX mode. This has to match the name of a DMXMode in the GDTF file.                                                      |
| Focus                                   | 0 or 1        | [UUID](#user-content-attrtype-uuid)          | A focus point reference that this lighting fixture aims at if this reference exists.                                                          |
| CastShadow                              | 0 or 1        | [Bool](#attrType-Bool)                       | Defines if a Object cast Shadows.                                                                                                             |
| Position                                | 0 or 1        | [UUID](#user-content-attrtype-uuid)          | A position reference that this lighting fixture belongs to if this reference exists.                                                          |
| FixtureID                               | 1             | [String](#user-content-attrtype-string)      | The Fixture ID of the lighting fixture. This is the short name of the fixture.                                                                |
| UnitNumber                              | 1             | [Integer](#user-content-attrtype-integer)    | The unit number of the lighting fixture in a position.                                                                                        |
| [Addresses](#node-definition-addresses) | 1             |                                              | The container for DMX Addresses for this fixture.                                                                                             |
| CIEColor                                | 0 or 1        | [CIE Color](#user-content-attrtype-ciecolor) | A color assigned to a fixture. If it is not defined, there is no color for the fixture.                                                       |
| FixtureTypeId                           | 0 or 1        | [Integer](#user-content-attrtype-integer)    | The Fixture Type ID is a value that can be used as a short name of the Fixture Type. This does not have to be unique. The default value is 0. |
| CustomId                                | 0 or 1        | [Integer](#user-content-attrtype-integer)    | The Custom ID is a value that can be used as a short name of the Fixture Instance. This does not have to be unique. The default value is 0.   |
| Mappings                                | 0 or 1        | [Mappings](#node-definition-mappings)        | The container for Mappings for this fixture.                                                                                                  |
| Gobo                                    | 0 or 1        | [Gobo](#node-definition-gobo)                | The Gobo used for the fixture. The image ressource must apply to the GDTF standard.                                                           |

Note: _The fixture has no `Geometries` node as geometry is defined in a
GDTF file._

An example of a node definition is shown below:

```xml
<Fixture name="Robe Robin MMX WashBeam" uuid="8BF13DD7-CBF4-415B-99E4-625FE4D2DAF6">
    <Matrix>{0.158127,-0.987419,0.000000}{0.987419,0.158127,0.000000}{0.000000,0.000000,1.000000}{6020.939200,2838.588955,4978.134459}</Matrix>
    <GDTFSpec>Custom@Robe Robin MMX WashBeam</GDTFSpec>
    <GDTFMode>DMX Mode</GDTFMode>
    <Focus>4A B1 94 62 A6 E3 4C 3B B2 5A D8 09 9F 78 17 0C</Focus>
    <Position>77 BC DE 16 95 A6 47 25 9D 04 16 A0 BD 67 CD 1A</Position>
    <Addresses>
        <Address break="0">45</Address>
    </Addresses>
    <Mappings>
        <Mapping linkedDef="BEF95EB8-98AC-4217-B10D-FB4B83381398">
            <ux>10</ux>
            <uy>10</uy>
            <ox>5</ox>
            <oy>5</oy>
            <rz>45</rz>
        </Mapping>
    </Mappings>
    <FixtureID></FixtureID>
    <UnitNumber>0</UnitNumber>
    <FixtureTypeId>0</FixtureTypeId>
    <CustomId>0</CustomId>
    <Color>{2.533316,-5.175210,3.699302}</Color>
    <Gobo rotation="32.5">image_file_forgobo</Gobo>
</Fixture>
```

### Node Definition: Gobo

This node defines a Gobo.

Node name: `Gobo`

| Attribute Name | Attribute Value Type                  | Default Value when Optional | Description                        |
| -------------- | ------------------------------------- | --------------------------- | ---------------------------------- |
| rotation       | [Float](#user-content-attrtype-float) | 0                           | The roation of the Gobo in degree. |

The node value is he Gobo used for the fixture. The image ressource must
apply to the GDTF standard. Use a FileName to specify.

### Node Definition: Addresses

This node defines a group of DMX Addresses.

Node name: `Addresses`

The child list contains a list of the following nodes:

| Child Node                          | Description             |
| ----------------------------------- | ----------------------- |
| [Address](#node-definition-address) | One address of fixture. |

#### Node Definition: Address

This node defines a DMX address.

Node name: `Address`

| Attribute Name | Attribute Value Type                      | Default Value when Optional | Description                                                                            |
| -------------- | ----------------------------------------- | --------------------------- | -------------------------------------------------------------------------------------- |
| break          | [Integer](#user-content-attrtype-integer) | 0                           | This is the break ident for this address. This value has to be unique for one fixture. |

<table>
<thead>
<tr class="header">
<th><p>Value Type</p></th>
<th><p>Default Value When Missing</p></th>
<th><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><a href="#user-content-attrtype-integer" title="wikilink"> Integer</a> or<a href="#user-content-attrtype-string" title="wikilink"> String</a></p></td>
<td><p><Not Optional></p></td>
<td><p>This is the DMX address.</p>
<p><code>Integer Format:</code><br />
<code>Absolute DMX address;</code></p>
<p><code>String format: </code><br />
<code>Universe - integer universe number, starting with 1; Address - address within universe from 1 to  512. </code><em><code>Universe.Address</code></em></p></td>
</tr>
</tbody>
</table>

### Node Definition: Mappings

This node defines a group of Mappings.

Node name: `Mappings`

The child list contains a list of the following nodes:

| Child Node                            | Allowed Count | Description                  |
| ------------------------------------- | ------------- | ---------------------------- |
| [Mappings](#node-definition-mappings) | 0 or any      | One Mapping for the fixture. |

It is only allowed to have one Mapping linked to the same
MappingDefinition once per Fixture.

#### Node Definition: Mapping

This node defines a Mapping.

Node name: `Mapping`

| Attribute Name | Attribute Value Type                | Default Value when Optional | Description                                                                                 |
| -------------- | ----------------------------------- | --------------------------- | ------------------------------------------------------------------------------------------- |
| linkedDef      | [UUID](#user-content-attrtype-uuid) |                             | The unique identifier of the MappingDefinition node that will be the source of the mapping. |

| Child Node | Allowed Count | Value Type | Description                                                                                                       |
| ---------- | ------------- | ---------- | ----------------------------------------------------------------------------------------------------------------- |
| [ux](#ux)  | 0 or 1        | Integer    | The offset in pixels in x direction from top left corner of the source that will be used for the mapped object.   |
| [uy](#uy)  | 0 or 1        | Integer    | The offset in pixels in y direction from top left corner of the source that will be used for the mapped object.   |
| [ox](#ox)  | 0 or 1        | Integer    | The size in pixels in x direction from top left of the starting point.                                            |
| [oy](#uy)  | 0 or 1        | Integer    | The size in pixels in y direction from top left of the starting point.                                            |
| [rz](#rz)  | 0 or 1        | Float      | The rotation around the middle point of the defined rectangle in degree. Positive direction is counter cock wise. |

Note: The transformation will be applied in the following order: -
Translation - Rotation

## Node Definition: Truss

This node defines a truss object.

Node name: `Truss`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | Not Optional                | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object               |

| Child Node                                | Allowed Count | Value Type                          | Description                                                                 |
| ----------------------------------------- | ------------- | ----------------------------------- | --------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix)         | 0 or 1        |                                     | The location of the object inside the parent coordinate system.             |
| [Position](#node-definition-position)     | 0 or 1        | [UUID](#user-content-attrtype-uuid) | A position reference that this truss belongs to if this reference exists.   |
| [Geometries](#node-definition-geometries) | 1             |                                     | A list of geometrical representation objects that are a part of the object. |

## Node Definition: VideoScreen

This node defines a video screen object.

Node name: `VideoScreen`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | <Not Optional>              | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object.              |

| Child Node                                | Allowed Count | Description                                                                 |
| ----------------------------------------- | ------------- | --------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix)         | 0 or 1        | The location of the object inside the parent coordinate system.             |
| [Geometries](#node-definition-geometries) | 1             | A list of geometrical representation objects that are a part of the object. |
| [Sources](#node-definition-sources)       | 0 or 1        | A list of video input sources..                                             |

An example of a node definition is shown below:

```xml
<VideoScreen name="Television" uuid="BEF95EB8-98AC-4217-B10D-FB4B83381398">
    <Matrix>{0.158127,-0.987419,0.000000}{0.987419,0.158127,0.000000}{0.000000,0.000000,1.000000}{6020.939200,2838.588955,4978.134459}</Matrix>
    <GDTFSpec>Generic@TV</GDTFSpec>
    <GDTFMode>DisplayModeWideScreen</GDTFMode>
    <Addresses>
        <Address break="0">45</Address>
    </Addresses>
    <FixtureID>25</FixtureID>
    <UnitNumber>0</UnitNumber>
    <FixtureTypeId>0</FixtureTypeId>
    <CustomId>0</CustomId>
    <Sources>
    movie.mov
   </Sources>
</Fixture>
```

## Node Definition: Projector

This node defines a video projector object.

Node name: `Projector`

| Attribute Name | Attribute Value Type                    | Default Value when Optional | Description                          |
| -------------- | --------------------------------------- | --------------------------- | ------------------------------------ |
| uuid           | [UUID](#user-content-attrtype-uuid)     | <Not Optional>              | The unique identifier of the object. |
| name           | [String](#user-content-attrtype-string) | Empty                       | The name of the object.              |

| Child Node                                 | Allowed Count | Description                                                                 |
| ------------------------------------------ | ------------- | --------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix)          | 0 or 1        | The location of the object inside the parent coordinate system.             |
| [Geometries](#node-definition-geometries)  | 1             | A list of geometrical representation objects that are a part of the object. |
| [Projections](#node-definition-projection) | 1             | A list of video source for Beam Geometries in the GDTF file.                |

An example of a node definition is shown below:
```xml
<Projector name="Projector" uuid="BEF95EB8-98AC-4217-B10D-FB4B83381398">
    <Matrix>{0.158127,-0.987419,0.000000}{0.987419,0.158127,0.000000}{0.000000,0.000000,1.000000}{6020.939200,2838.588955,4978.134459}</Matrix>
    <GDTFSpec>Generic@Projector</GDTFSpec>
    <GDTFMode>Projector@ThrowRatio1_7_to_2_2</GDTFMode>
    <Addresses>
        <Address break="0">45</Address>
    </Addresses>
    <FixtureID>25</FixtureID>
    <UnitNumber>0</UnitNumber>
    <FixtureTypeId>0</FixtureTypeId>
    <CustomId>0</CustomId>
    <Projections>
        <Projection>movie.mov
            
            <ScaleHandeling>UpScale</ScaleHandeling>
        </Projection>
    </Projections>
</Projector> 
```

### Node Definition: Projections

This node defines a group of Projections.

Node name: `Projections`

The child list contains a list of the following nodes:

| Child Node                                | Description             |
| ----------------------------------------- | ----------------------- |
| [Projection](#node-definition-projection) | Defines the Projection. |

#### Node Definition: Projection

This node defines a Projection.

Node name: `Projection`

The child list contains a list of the following nodes:

| Child Node                                        | Description                                      |
| ------------------------------------------------- | ------------------------------------------------ |
| [Source](#node-definition-source)                 | Defines the source for the projection.           |
| [ScaleHandeling](#node-definition-scalehandeling) | How the source will be scaled to the projection. |

# Other Node Definition

## Node Definition: Sources

This node defines a group of sources for VideoScreen.

Node name: `Sources`

The child list contains a list of the following nodes:

| Child Node                        | Description                 |
| --------------------------------- | --------------------------- |
| [Source](#node-definition-source) | One Source for the fixture. |

### Node Definition: Source

This node defines a Source.

Node name: `Source`

<table>
<thead>
<tr class="header">
<th><p>Attribute Name</p></th>
<th><p>Attribute Value Type</p></th>
<th><p>Default Value when Optional</p></th>
<th><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>linkedGeometry</p></td>
<td><p><a href="#user-content-attrtype-string" title="wikilink"> String</a></p></td>
<td><p><em><Not Optional></em></p></td>
<td><p>For a Display: The GDTF Geometry Type Display whose linked texture will get replaced by the source value.</p>
<p><code> For a Beam: Defines the source for the GDTF Geometry Type Beam. Only applicable when BeamType is "Rectangle".</code></p></td>
</tr>
<tr class="even">
<td><p>type</p></td>
<td><p><a href="#attrType-Enum" title="wikilink"> Enum</a></p></td>
<td><p><em><Not Optional></em></p></td>
<td><p>Defines the type of source of the media ressource that will be used. The currently defined types are: NDI, File, CITP, CaptureDevice</p></td>
</tr>
</tbody>
</table>

<table>
<thead>
<tr class="header">
<th><p>Value Type</p></th>
<th><p>Default Value When Missing</p></th>
<th><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>String</p></td>
<td><p><em><Not Optional></em></p></td>
<td><p>When NDI/CITP -&gt; Stream Name</p>
<p><code> When File -&gt; Filename in MVR file</code><br />
<code> When CaptureDevice -&gt; CaptureDevice Name</code></p></td>
</tr>
</tbody>
</table>

### Node Definition: ScaleHandeling

This node defines how the MappingDefinition will react if the video
source has not the same resolution.

Node name: `ScaleHandeling`

| Value Type | Default Value When Missing | Description                                                                     |
| ---------- | -------------------------- | ------------------------------------------------------------------------------- |
| Enum       | ScaleKeepRatio             | The available value are `ScaleKeepRatio`, `ScaleIgnoreRatio`, `KeepSizeCenter`. |

## Node Definition: Geometries

This node defines a group of graphical objects.

Node name: `Geometries`

The child list contains a list of the following nodes:

| Child Node                                | Description                                                          |
| ----------------------------------------- | -------------------------------------------------------------------- |
| [Geometry3D](#node-definition-geometry3d) | The geometry of this definition that will be instanced in the scene. |
| [Symbol](#node-definition-symbol)         | The symbol instance that will provide a geometry of this definition. |

## Node Definition: Symbol

This node specified a symbol instance (geometry insert) of the
definition geometry defined by a [
Symdef](#node-definition-symdef) node.

Node name: `Symbol`

| Attribute Name | Attribute Value Type                | Default Value when Optional | Description                                                                   |
| -------------- | ----------------------------------- | --------------------------- | ----------------------------------------------------------------------------- |
| uuid           | [UUID](#user-content-attrtype-uuid) | Not Optional                | The unique identifier of the object.                                          |
| symdef         | [UUID](#user-content-attrtype-uuid) | Not Optional                | The unique identifier of the Symdef node that will be the source of geometry. |

| Child Node                        | Allowed Count | Description                                                                                                                                                               |
| --------------------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix) | 0 or 1        | The transformation matrix that defines the location. orientation and scale of the geometry inside the local coordinate space of the container. Considered identity when missing. |

## Node Definition: Geometry3D

This node provides a geometry from an external file. The type of the
file is determined by the extension.

Node name: `Geometry3D`

| Attribute Name | Attribute Value Type                        | Default Value when Optional | Description                                                                                                                                  |
| -------------- | ------------------------------------------- | --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| fileName       | [FileName](#user-content-attrtype-filename) | Not Optional                | The file name, including extension, of the external file in the archive. If there is no extension, it will assume that the extension is 3ds. |

| Child Node                        | Allowed Count | Description                                                                                                                                                               |
| --------------------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Matrix](#node-definition-matrix) | 0 or 1        | The transformation matrix that defines the location, orientation and scale of the geometry inside the local coordinate space of the container. Considered identity when missing. |

## Node Definition: Matrix

This node contains a definition of a transformation matrix.

Node name: `Matrix`

<table>
<thead>
<tr class="header">
<th><p>Value Type</p></th>
<th><p>Default Value When Missing</p></th>
<th><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>{float,float,float}{float,float,float}{float,float,float}</p></td>
<td><p>{1,0,0}{0,1,0}{0,0,1}{0,0,0}</p></td>
<td><p>This node contains the array for a 4x3 transform matrix.</p>
<p><code>The order is</code><br />
<code>u1,u2,u3</code><br />
<code>v1,v2,v3</code><br />
<code>w1,w2,w3</code><br />
<code>o1,o2,o3</code></p></td>
</tr>
</tbody>
</table>

## Node Definition: ChildList

This node defines a list of graphical objects.

Node name: `ChildList`

The child list contains a list of one of the following nodes:

| Child Node                                  | Description                                                                  |
| ------------------------------------------- | ---------------------------------------------------------------------------- |
| [SceneObject](#node-definition-sceneobject) | A generic graphical object from the scene.                                   |
| [GroupObject](#node-definition-groupobject) | A grouping object of other graphical objects inside local coordinate system. |
| [FocusPoint](#node-definition-focuspoint)   | A definition of a focus point.                                               |
| [Fixture](#node-definition-fixture)         | A definition of a fixture.                                                   |
| [Truss](#node-definition-truss)             | A definition of a truss.                                                     |
| [VideoScreen](#node-definition-videoscreen) | A definition of a video screen.                                              |

# Generic Value Types

Here is a list of the available types for node or attribute values:

| Value Type Name                               | Description                                                                                                                                                                                       |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <span id="attrType-Integer"> Integer </span>  | A signed or unsigned integer value. Uses a dash ('-') as a prefix to denote negative numbers.                                                                                                     |
| <span id="attrType-Float"> Float </span>      | A floating point numeric value. Uses a decimal point ('.') as an integer-read delimiter.                                                                                                          |
| <span id="attrType-String"> String </span>    | Any sequence of symbols. The following symbols will be used (with their meaning in brackets) according to the XML standard: `&lt;` (\<), `&amp;` (&), `&gt;` (\>), `&quot;` ("), and `&apos;` (') |
| <span id="attrType-UUID"> UUID </span>        | XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX                                                                                                                                                              |
| <span id="attrType-Vector">Vector</span>      | A three Float values separated by ',' defining a 3D vector's X, Y, and Z components.                                                                                                              |
| <span id="attrType-FileName">FileName</span>  | A file name defined by letters A-Z , a-z plus numbers 0-9 and the symbol '\_'. The extension is defined by a list of A-Z and a-z letters delimited from the name by '.'                           |
| <span id="attrType-CIEColor">CIE Color</span> | CIE color representation xyY 1931. The Node value is: {floatx, floaty, floatY}                                                                                                                    |

# Revision History

This section lists all the changes that are made to MVR.

## Version 1.0

- Created the file format specification.

## Version 1.1

- Added information about the name of the archive
- Updated version attributes from the root node. We now have to
  integer values for this.
- The version attribute from the UserData node is now a String so it
  can contain any data.
- Make it clear that the SymDef can contain Symbol and Geometry3D
  nodes.
- Geometry3D file attribute defines the behavior if there is no
  extension for a file.
- Changed the matrix definition to match GDTF.
- Make it clear that a layers parent coordinate system is the global
  coordinate space.
- Give the option to have multiple addresses.
- Add DMX node to fixture. This can be used to define the DMX Mode for
  the GDTF file.

## Version 1.2

- Fixed a copy error in the Addresses Node. An Addresses Node can only
  contain Address Nodes.
- GDTFMode Node name now without white space.
- Added CIE Color for Fixture Node.
- Added Fixture Type ID
- Added Custom ID

## Version 1.3

- Fixed spelling mistakes.

## Version 1.4

- Updated UUID printing to match GDTF.

## Version 1.5

- Add support for Media Server and Mapping.
