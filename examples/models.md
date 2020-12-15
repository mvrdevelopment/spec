# Models

The model collect contains model description of the fixture parts. To visualize a geometry there has to be a corresponding model for each geometry. The link to the model is defined in the geometries. 

These examples correspond to the examples in the topic "Geometry".

## Example - PARcan

First example is a basic PARcan. We only need two models here. The size of the body is 0.25m x 0.25m x 0.4m. The model links to a 3D resource file. The link to the 3D models is set using the attribute `File`. Enter the name of the 3D file without a file extension. If there is no 3D model, use a primitive type to visualize the model. The second model is used to describe the point of the light exit.

```
<Models>
    <Model Name="Body" Length="0.25" Width="0.25" Height="0.4" PrimitiveType="Cylinder" File="Body"/>
    <Model Name="Beam" Length="0.2" Width="0.2" Height="0.02" PrimitiveType="Cylinder" File="Beam">
</Models>
```

## Example – Basic Moving Head

The second example is a basic moving head consisting of four models – Base, Yoke, Head and Beam.

```
<Models>
    <Model Name="Base" Length="0.3" Width="0.3" Height="0.15" PrimitiveType="Cube" File="Base" />
    <Model Name="Yoke" Length="0.4" Width="0.1" Height="0.3" PrimitiveType="Cube" File="Yoke"/>
    <Model Name="Head" Length="0.25" Width="0.25" Height="0.3" PrimitiveType="Cylinder" File= "Head"/>
    <Model Name="Beam" Lenght="0.05" Width="0.05" Height="0.02" PrimitiveType="Cylinder" File="Beam">
</Models>
```
 
## Example – More Complex Fixture Type

Third example deals with a more complex moving head that consists of a bar (Yoke1) that is mounted to Base1. Four smaller versions of the basic moving head are mounted to this bar.
You need six models to create this fixture type. On the one hand, these are Base1 and Yoke1 (Bar) – they build the basic structure. On the other hand, these are the four models that build the basic moving head (Base2, Yoke2, Head and Beam).

```
<Models>
    <Model Name="Base1" Length="0.3" Width="0.3" Height="0.2" PrimitiveType="Cube" File="Base" />
    <Model Name="Yoke1" Length="1.3" Width="0.2" Height="0.2" PrimitiveType="Cube" File="Body" />
    <Model Name="Base2" Length="0.1" Width="0.1" Height="0.05" PrimitiveType="Cube" File="Yoke1" />
    <Model Name="Yoke2" Length="0.2" Width="0.1" Height="0.2" PrimitiveType="Cube" File="Yoke2" />
    <Model Name="Head" Length="0.15" Width="0.15" Height="0.25" PrimitiveType="Cylinder" File="Head" />
    <Model Name="Beam" Lenght="0.05" Width="0.05" Height="0.02" PrimitiveType="Cylinder" File="Beam">
</Models>
```
## Example - LED Panel

The fourth example is a 3x3 LED panel consisting of two models. The model of the housing is called Body and the model of the LED light source is called Pixel.

```
<Models>
    <Model Name="Pixel" Length="0.02" Width="0.02" Height="0.005" PrimitiveType="Cylinder" File="Pixel" />
    <Model Name="Body" Length="0.3" Width="0.3" Height="0.01" PrimitiveType="Cube" File="Body" />
</Models>
```
