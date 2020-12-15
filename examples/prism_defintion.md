# Prism Definition

In the most generic sense there is an entry for each facet specifying the rotation, translation and scaling for each facet.

```
{[M11],[M12],[M13]},{[M21],[M22],[M23]},{[M31],[M32],[M33]}
```
 
 
'''3 facet Prism'''

```
<Facet Rotation="{0.6, 0.0, 0.0},{ 0.0, 0.6, 0.0},{ -0.12,  0.15, 1.0}"/>
<Facet Rotation="{0.6, 0.0, 0.0},{ 0.0, 0.6, 0.0},{  0.17,  0.0,  1.0}"/>
<Facet Rotation="{0.6, 0.0, 0.0},{ 0.0, 0.6, 0.0},{ -0.12, -0.15, 1.0}"/>
```

If you have a look how how the prism effect actually look like, it is 
like duplicating the beam from a fixture with a offset. For a 3facet prism
Something like this happens:
''Add picture here''
When you know have a look on the transform matrixes, you can write them 
In normal matrix notation:

'''Prism 1'''

```
0,6		0		0,12		// Scale X, X Offset
0		0,6		0,15		// Scale Y, Y Offset
0		0		1,0		    // Scale
```

'''Prism 2'''

```
0,6		0		0,12		// Scale X, X Offset
0		0,6		0,15		// Scale Y, Y Offset
0		0		1,0		    //  Scale
```


'''Prism 3'''

```
0,6		0		0,12		// Scale X, X Offset
0		0,6		0,15		// Scale Y, Y Offset
0		0		1,0		    //  Scale
```

This matrixes are 2D transform matrixes. Wikipedia has a nice graphical chart how this is working.
https://en.wikipedia.org/wiki/Transformation_matrix#/media/File:2D_affine_transformation_matrix.svg

So this transform matrix has a scale component in the first two rows, and the last row is Offset X, Offset Y, Scale.
All of this is unit less, if you go 1 step forward, the offset is X%,X% from this this steps.
The actual transform can be freely defined. For example shear, rotation translation and mirroring.
