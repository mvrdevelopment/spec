# Wheels

Wheel collects are used to describe all fixture wheels. For example, color wheels, gobo wheels or prism wheels.
The wheel collect contains wheels. Each wheel in the collect describes one physical wheel of the fixture type. Every wheel has several slots which describe a slot of the physical wheel (e.g., a color or a gobo). If the wheel slot contains a prism, it has to have one or several children that are called prism facet.

Example: fixture with two wheels – color wheel, and gobo wheel.
The color wheel has seven independent slots that represent a different color each. These are "Open", "Red", "Green", "Blue", "Cyan", "Magenta" and "Yellow". The colors have to be described as xyY-values in CIE 1931 color space.
The gobo wheel has six slots (5 gobos + open). Each gobo slot refers to a media file that contains an image of the respective gobo. The specifications of the media files can be found in the format description of the GDTF. The file name has to be given without file extension.

```
<Wheels>
    <Wheel Name="ColorWheel">
        <Slot Name="Open" />
        <Slot Name="Red" Color="0.64,0.33,21,26" />
        <Slot Name="Green" Color="0.3,0.6,71.52" />
        <Slot Name="Blue" Color="0.15,0.06,7.22" />
        <Slot Name="Cyan" Color="0.2247,0.3287,78.74" />
        <Slot Name="Magenta" Color="0.3209,0.1542,28.48" />
        <Slot Name="Yellow" Color="0.4193,0.5053,92.78" />
    </Wheel>
    <Wheel Name="GoboWheel">
        <Slot Name="Open" />
        <Slot Name="Gobo 1" MediaFileName="Gobo1" />
        <Slot Name="Gobo 2" MediaFileName="Gobo2" />
        <Slot Name="Gobo 3" MediaFileName="Gobo3" />
        <Slot Name="Gobo 4" MediaFileName="Gobo4" />
        <Slot Name="Gobo 5" MediaFileName="Gobo5" />
    </Wheel>
</Wheels>
```