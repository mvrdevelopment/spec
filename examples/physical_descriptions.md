# Physical Descriptions

This section describes the physical properties of the device. For example, the color of emitters. It is also possible to define a DMX profile that is used to describe nonlinear correlation between DMX input and physical output of a channel.

The first example deals with the definition of the color of emitters. In this example the color (CIE color values) of five different emitters is defined via their color values measured in a real life fixture. The color has to be defined in the CIE 1931 color space. The format is Color="coordinate x,coordinate y, luminance Y".

```
<PhysicalDescriptions>
    <ColorSpace/>
    <Filters/>

    <Emitters>
        <Emitter Color="0.6951,0.3044,100" Name="measured R">
            <Measurement LuminousIntensity="534" Physical="100"> 
                <MeasurementPoint Energy="0.048200" WaveLength="634"/>
                <MeasurementPoint Energy="0.069000" WaveLength="637"/>
                <MeasurementPoint Energy="0.073700" WaveLength="640"/>
                <MeasurementPoint Energy="0.047800" WaveLength="643"/>
                <MeasurementPoint Energy="0.021700" WaveLength="646"/>
            </Measurement> 
        </Emitter>
        <Emitter Color="0.3002,0.5998,71,55" Name="measured G">
            <Measurement LuminousIntensity="974" Physical="100" />
        </Emitter>
        <Emitter Color="0.1503,0.0602,7.246" Name="measured B">
            <Measurement LuminousIntensity="236" Physical="100" />
        </Emitter>
        <Emitter Color="0.473,0.4623,58,526" Name="measured A">
            <Measurement LuminousIntensity="1076" Physical="100" />
        </Emitter>
        <Emitter Color="0.3104,0.3242,96,1" Name="measured W">
            <Measurement LuminousIntensity="1344" Physical="100" />
        </Emitter>
    </Emitters>

    <DMXProfiles/>
    <CRIs/>
</PhysicalDescriptions>
```


The link to a emitter has to be set in the channel function. The following is an example of `ColorAdd_R`.

```
<DMXChannel Offset="5" Default="255/1" Highlight="255/1" Geometry="Head">
    <LogicalChannel Attribute="ColorAdd_R" >
        <ChannelFunction Attribute="ColorAdd_R" DMXFrom="0/1" PhysicalFrom="0" PhysicalTo="1" Emitter="measured R">
        </ChannelFunction>
    </LogicalChannel>
</DMXChannel>
```