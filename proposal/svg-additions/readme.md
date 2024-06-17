## Additional features inside SVG files

### SVG can define additional features:

* Movement Range: shapes inside the SVG with fill and stroke color Red (#FF0000
  (RGB: 255, 0, 0)) and with fill and stroke opacity 0, allow software to
  identify these shapes as a movement range of the device.

* Connection Input (Pigtail): shapes inside the SVG with fill and stroke color
  Green (#00FF00 (RGB: 0, 255, 0)) and with fill and stroke opacity 0, allow
  software to identify these shapes as a connection input (pigtail) part of the
  device.

SVG needs to be aligned with the GDTF 3D model. GDTF 3D front is down in SVG.

> Note: the opacity 0 is used for backwards compatibility

> Example: If Pigtail is at the back of the unit, is drawn up in SVG.

Attached examples:

![labeled thumbnail](./thumbnail_labeled.png)

![resulted thumbnail](./thumbnail.svg)

> **Note**
> The top SVG contains this element generating the pigtail. As the opacity is set the zero, in the rendered SVG you will not see it.

```svg
<rect
    style="fill:#00ff00;stroke:#00ff00;stroke-width:1.5;stroke-linejoin:bevel;fill-opacity:0;stroke-opacity:0"
    id="rect5567"
    width="202.29604"
    height="38.859127"
    x="136.35199"
    y="89.147408"
    inkscape:label="pigtailRectangle" />
```