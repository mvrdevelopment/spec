# Geometry

Geometries are used to describe the physical and logical dependencies of a fixture type. For example, dependencies between pan and tilt rotation as well as dependencies between a master dimmer and a dimmer of a subfixture. A valid GDTF fixture type has to have at least one geometry.

## Example - PARcan

The first example shows the geometry of a simple PARcan that has a dimmer attribute only. There are two geometry objects needed to describe the fixture. One with the type "Geometry" that describes the housing and one with the type "Beam" that it is used to describe the position of the exit point of light. The properties of the different geometry types are described in the format description of the GDTF.

'''Geometrical Structure:'''
- :Body – type: Geometry
- ::Beam - type: Beam

```
<Geometries>
    <Geometry Name="Body" Model="Body">
        <Beam Name="Beam" Model="Beam" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.200000}{0.000000,0.000000,0.000000,1.000000}" LampType="Halogen" PowerConsumption="1000" LuminousFlux="28000" ColorTemperature="3200" BeamAngle="14" FieldAngle="22" BeamRadius="0.1" />
    </Geometry>
</Geometries>
```


## Example - Basic Moving Head

The second example shows the geometry of a basic moving head. There are Base, Yoke, Head and Beam. Yoke and Head are of the geometry type "Axis" while Base is of the type "Geometry" and Beam of the type "Beam". There are dependencies between these four which are described by the structure of the geometry collect. Yoke depends on Base, while Head depends on Yoke and Base as it is in a real moving light. The positioning of Yoke depends on the pan that is located in the Yoke itself. Furthermore, the positioning of Head depends on the tilt that is located in the Head itself. Yoke, on the other hand, depends on Base. A DMX channel that has a pan or tilt attribute assigned to its logical channel affects the rotation of the geometry it is linked to. The positioning of the point of light exit (Beam) depends on the orientation of the Head. In case of this example the geometry "Beam" is located at the position of the lens of the Basic Moving Light.

__Geometrical Structure:__
- :Base – type: Geometry
- ::Yoke – type: Axis
- :::Head – type: Axis
- ::::Beam - type: Beam
		
```
<Geometries>
    <Geometry Name="Base" Model="Base">
        <Axis Name="Yoke" Model="Yoke" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.225000}{0.000000,0.000000,0.000000,1.000000}">
            <Axis Name="Head" Model="Head" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.100000}{0.000000,0.000000,0.000000,1.000000}">
                <Beam Name="Beam" Model="Beam" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.150000}{0.000000,0.000000,0.000000,1.000000}" LampType="Discharge" PowerConsumption="350" LuminousFlux="12000" ColorTemperature="6500" BeamAngle="20" FieldAngle="22" BeamRadius="0.025" BeamType="Spot" ColorRenderingIndex="75" />
            </Axis>
        </Axis>
    </Geometry>
</Geometries>
```

## Example - More Complex Fixture Type

The third example shows the geometry of a more complex fixture type. This fixture consists of four basic moving heads that are mounted to a bar that can rotate by an additional pan. Geometry references are used to describe the geometry of this fixture. A geometrical reference is a type of geometry that references to a geometrical structure.

In this example there are two geometrical trees. The first one (starting with "Yoke1") only describes the geometry of the small basic moving head, while the second one (starting with Base) describes the whole device. The first geometrical tree has the same structure as the basic moving head in the previous example. The second one has the start geometry Base. That geometry is of the type Axis, which has a child named Body. This child is of the geometry type Geometry. The geometry type Geometry does not have a special function, but can be used to be linked to a 3D model.

Body has four children which are of the geometry type Geometry Reference. These four geometries reference the start geometry of the basic moving head. Each of the geometry references has a DMX offset which determines the order of the DMX channels.
The offset depends on the relative DMX patch addresses that are set for the DMX channels in the DMX channel collect.

A possible DMX chart of this fixture type:

1	Pan Yoke 1<br>
2	Master dimmer<br>
--- Head 1 --- Geometry Reference DMX Offset 1<br>
3	Pan Head 1<br>
4	Tilt Head 1<br>
5	ColorAdd_R Head 1<br>
6	ColorAdd_G Head 1<br>
7	ColorAdd_B Head 1<br>
8	ColorAdd_RY Head 1<br>
9	ColorAdd_W Head 1<br>
--- Head 2 --- Geometry Reference DMX Offset 8<br>
10	Pan Head 2<br>
11	Tilt Head 2<br>
12	ColorAdd_R Head 2<br>
13	ColorAdd_G Head 2<br>
14	ColorAdd_B Head 2<br>
15	ColorAdd_RY Head 2<br>
16	ColorAdd_W Head 2<br>
--- Head 3 --- Geometry Reference DMX Offset 15<br>
17	Pan Head 3<br>
18	ColorAdd_R Head 3<br>
19	ColorAdd_G Head 3<br>
20	ColorAdd_B Head 3<br>
21	ColorAdd_RY Head 3<br>
22	ColorAdd_W Head 3<br>
23 	Tilt Head 3<br>
--- Head 4 --- Geometry Reference DMX Offset 22<br>
24	Pan Head 4<br>
25 	Tilt Head 4<br>
26	ColorAdd_R Head 4<br>
27	ColorAdd_G Head 4<br>
28	ColorAdd_B Head 4<br>
29	ColorAdd_RY Head 4<br>
30	ColorAdd_W Head 4

'''Geometrical Structure:'''
:Base2 – type: Geometry (start geometry 1)
::Yoke2 – type: Axis
:::Head – type: Axis
::::Beam - type: Beam
		
:Base1 – type: Geometry (start geometry 2)
::Yoke1 – type: Axis
:::Head1 – type: Geometry Reference (1) referencing Yoke1
:::Head2 – type: Geometry Reference (2) referencing Yoke1
:::Head3 – type: Geometry Reference (3) referencing Yoke1
:::Head4 – type: Geometry Reference (4) referencing Yoke1

Geometries that are on the same level do not depend on each other while child geometries always depend on their parents, grandparents and so on. In relation to this example this means that a dimmer that is assigned to the geometry Base1 reacts as a master dimmer for a (virtual) dimmer that is assigned to each of the four heads.

```
<Geometries>
    <Geometry Name="Base2" Model="Base2">
        <Axis Name="Yoke2" Model="Yoke2" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.225000}{0.000000,0.000000,0.000000,1.000000}">
            <Axis Name="Head" Model="Head" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.100000}{0.000000,0.000000,0.000000,1.000000}">
                <Beam Name="Beam" Model="Beam" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.150000}{0.000000,0.000000,0.000000,1.000000}" LampType="Discharge" PowerConsumption="350" LuminousFlux="12000" ColorTemperature="6500" BeamAngle="20" FieldAngle="22" BeamRadius="0.025" BeamType="Spot" ColorRenderingIndex="75" />
            </Axis>
        </Axis>
    </Geometry>
    <Geometry Name="Base1" Model="Base1">
        <Geometry Name="Yoke1" Model="Yoke1" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.200000}{0.000000,0.000000,0.000000,1.000000}">
            <GeometryReference Name="Head1" Position="{1.000000,0.000000,0.000000,-0.550000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.125000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Base2">
                <Break DMXOffset="1" />
            </GeometryReference>
            <GeometryReference Name="Head2" Position="{1.000000,0.000000,0.000000,-0.183000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.125000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Base2">
                <Break DMXOffset="8" />
            <GeometryReference Name="Head3" Position="{1.000000,0.000000,0.000000,0.183000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.125000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Base2">
                <Break DMXOffset="15" />
            </GeometryReference>
            <GeometryReference Name="Head4" Position="{1.000000,0.000000,0.000000,0.550000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.125000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Base2">
                <Break DMXOffset="22" />
            </GeometryReference>
        </Axis>
    </Geometry>
</Geometries>
```

## Example - LED Panel
		
The forth example shows the geometry tree of an LED panel with 3x3 RGB LEDs. There is a geometry type "Beam" called "Pixel" that is referenced to nine times. 

'''Geometrical Structure:'''
:Pixel – type: Beam
:Body – type: Geometry
::Pixel1 – type: Geometry Reference (1) referencing Pixel
::Pixel2 – type: Geometry Reference (2) referencing Pixel
::Pixel3 – type: Geometry Reference (3) referencing Pixel
::Pixel4 – type: Geometry Reference (4) referencing Pixel
::Pixel5 – type: Geometry Reference (5) referencing Pixel
::Pixel6 – type: Geometry Reference (6) referencing Pixel
::Pixel7 – type: Geometry Reference (7) referencing Pixel
::Pixel8 – type: Geometry Reference (8) referencing Pixel
::Pixel9 – type: Geometry Reference (9) referencing Pixel

```
<Geometries>
    <Beam Name="Pixel" Model="Pixel" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,-0.020000}{0.000000,0.000000,0.000000,1.000000}" LampType="LED" />
    <Geometry Name="Body" Model="Body">
        <GeometryReference Name="Pixel1" Position="{1.000000,0.000000,0.000000,-0.100000}{0.000000,1.000000,0.000000,0.100000}{0.000000,0.000000,1.000000,0.000000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Pixel">
            <Break DMXOffset="1" />
        </GeometryReference>
        <GeometryReference Name="Pixel2" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,0.100000}{0.000000,0.000000,1.000000,0.000000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Pixel">
            <Break DMXOffset="4" />
        </GeometryReference>
        <GeometryReference Name="Pixel3" Position="{1.000000,0.000000,0.000000,0.100000}{0.000000,1.000000,0.000000,0.100000}{0.000000,0.000000,1.000000,0.000000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Pixel">
            <Break DMXOffset="7" />
        </GeometryReference>
        <GeometryReference Name="Pixel4" Position="{1.000000,0.000000,0.000000,-0.100000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,0.000000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Pixel">
            <Break DMXOffset="10" />
        </GeometryReference>
        <GeometryReference Name="Pixel5" Geometry="LED">
            <Break DMXOffset="13" />
        </GeometryReference>
        <GeometryReference Name="Pixel6" Position="{1.000000,0.000000,0.000000,0.100000}{0.000000,1.000000,0.000000,0.000000}{0.000000,0.000000,1.000000,0.000000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Pixel">
            <Break DMXOffset="16" />
        </GeometryReference>
        <GeometryReference Name="Pixel7" Position="{1.000000,0.000000,0.000000,-0.100000}{0.000000,1.000000,0.000000,-0.100000}{0.000000,0.000000,1.000000,0.000000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Pixel">
            <Break DMXOffset="19" />
        </GeometryReference>
        <GeometryReference Name="Pixel8" Position="{1.000000,0.000000,0.000000,0.000000}{0.000000,1.000000,0.000000,-0.100000}{0.000000,0.000000,1.000000,0.000000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Pixel">
            <Break DMXOffset="22" />
        </GeometryReference>
        <GeometryReference Name="Pixel9" Position="{1.000000,0.000000,0.000000,0.100000}{0.000000,1.000000,0.000000,-0.100000}{0.000000,0.000000,1.000000,0.000000}{0.000000,0.000000,0.000000,1.000000}" Geometry="Pixel">
            <Break DMXOffset="25" />
        </GeometryReference>
    </Geometry>
</Geometries>
```