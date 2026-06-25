## Cable definition GDTF

### Power cable, Schuko to Schuko

```xml
<Cable Name="Power Cable Schuko to Schuko"
       LengthMin="1.0"
       LengthMax="25.0"
       AvailableLengths="1.0,5.0,10.0,25.0"
       Diameter="0.02"
       WeightPerMeter="0.002"
       InstallationRating="Touring">
  <WiringObject Name="A"
                ConnectorType="CEE 7/7"
                ComponentType="Input"
                SignalType="Power"
                PinCount="3" />
  <WiringObject Name="B"
                ConnectorType="CEE 7/7"
                ComponentType="Output"
                SignalType="Power"
                PinCount="3" />
  <Conductors Name="Power" Type="Power" CrossSection="1.5" ConductorAmount="3" VoltageRating="250" CurrentRating="16">
    <PinPatch FromWiringObject="A" FromPin="1" ToWiringObject="B" ToPin="1" />
    <PinPatch FromWiringObject="A" FromPin="2" ToWiringObject="B" ToPin="2" />
    <PinPatch FromWiringObject="A" FromPin="3" ToWiringObject="B" ToPin="3" />
  </Conductors>
</Cable>
```

### Power cable, Schuko to PowerTrueOne

```xml
<Cable Name="Power Cable Schuko to PowerTrueOne"
       LengthMin="1.0"
       LengthMax="25.0"
       AvailableLengths="1.0,5.0,10.0,25.0"
       InstallationRating="Touring">
  <WiringObject Name="A"
                ConnectorType="CEE 7/7"
                ComponentType="Input"
                SignalType="Power"
                PinCount="3" />
  <WiringObject Name="B"
                ConnectorType="PowerTrueOne"
                ComponentType="Output"
                SignalType="Power"
                PinCount="3" />
  <Conductors Name="Power" Type="Power" CrossSection="1.5" ConductorAmount="3" VoltageRating="250" CurrentRating="16">
    <PinPatch FromWiringObject="A" FromPin="1" ToWiringObject="B" ToPin="1" />
    <PinPatch FromWiringObject="A" FromPin="2" ToWiringObject="B" ToPin="2" />
    <PinPatch FromWiringObject="A" FromPin="3" ToWiringObject="B" ToPin="3" />
  </Conductors>
</Cable>
```

### DMX cable, XLR to XLR

```xml
<Cable Name="DMX Cable XLR to XLR"
       LengthMin="1.0"
       LengthMax="100.0"
       AvailableLengths="1.0,5.0,10.0,25.0,50.0,100.0"
       InstallationRating="Touring">
  <WiringObject Name="A"
                ConnectorType="XLR3"
                ComponentType="Input"
                SignalType="DMX512"
                PinCount="3" />
  <WiringObject Name="B"
                ConnectorType="XLR3"
                ComponentType="Output"
                SignalType="DMX512"
                PinCount="3" />
  <Conductors Name="DMX" Type="DMX512" ConductorAmount="3" Impedance="120">
    <PinPatch FromWiringObject="A" FromPin="1" ToWiringObject="B" ToPin="1" />
    <PinPatch FromWiringObject="A" FromPin="2" ToWiringObject="B" ToPin="2" />
    <PinPatch FromWiringObject="A" FromPin="3" ToWiringObject="B" ToPin="3" />
  </Conductors>
</Cable>
```

### Combined cable, power and DMX, four connectors

```xml
<Cable Name="Power and DMX Combo, split ends"
       LengthMin="1.0"
       LengthMax="50.0"
       AvailableLengths="1.0,5.0,10.0,25.0,50.0"
       InstallationRating="Touring">
  <WiringObject Name="Power-In"
                ConnectorType="CEE 7/7"
                ComponentType="Input"
                SignalType="Power"
                PinCount="3" />
  <WiringObject Name="Power-Out"
                ConnectorType="PowerTrueOne"
                ComponentType="Output"
                SignalType="Power"
                PinCount="3" />
  <WiringObject Name="DMX-In"
                ConnectorType="XLR3"
                ComponentType="Input"
                SignalType="DMX512"
                PinCount="3" />
  <WiringObject Name="DMX-Out"
                ConnectorType="XLR3"
                ComponentType="Output"
                SignalType="DMX512"
                PinCount="3" />
  <Conductors Name="Power" Type="Power" CrossSection="1.5" ConductorAmount="3" VoltageRating="250" CurrentRating="16">
    <PinPatch FromWiringObject="Power-In" FromPin="1" ToWiringObject="Power-Out" ToPin="1" />
    <PinPatch FromWiringObject="Power-In" FromPin="2" ToWiringObject="Power-Out" ToPin="2" />
    <PinPatch FromWiringObject="Power-In" FromPin="3" ToWiringObject="Power-Out" ToPin="3" />
  </Conductors>

  <Conductors Name="DMX" Type="DMX512" ConductorAmount="3" Impedance="120">
    <PinPatch FromWiringObject="DMX-In" FromPin="1" ToWiringObject="DMX-Out" ToPin="1" />
    <PinPatch FromWiringObject="DMX-In" FromPin="2" ToWiringObject="DMX-Out" ToPin="2" />
    <PinPatch FromWiringObject="DMX-In" FromPin="3" ToWiringObject="DMX-Out" ToPin="3" />
  </Conductors>
</Cable>
```
### Combined cable, power and DMX, two Amphenol connectors

```xml
<Cable Name="Power and DMX Combo, single connector each side"
       LengthMin="1.0"
       LengthMax="50.0"
       AvailableLengths="1.0,5.0,10.0,25.0,50.0"
       InstallationRating="Touring">
  <WiringObject Name="A"
                ConnectorType="Amphenol"
                ComponentType="Input"
                PinCount="6" />
  <WiringObject Name="B"
                ConnectorType="Amphenol"
                ComponentType="Output"
                PinCount="6" />
  <Conductors Name="Power" Type="Power" CrossSection="1.5" ConductorAmount="3" VoltageRating="250" CurrentRating="16">
    <PinPatch FromWiringObject="A" FromPin="1" ToWiringObject="B" ToPin="1" />
    <PinPatch FromWiringObject="A" FromPin="2" ToWiringObject="B" ToPin="2" />
    <PinPatch FromWiringObject="A" FromPin="3" ToWiringObject="B" ToPin="3" />
  </Conductors>

  <Conductors Name="DMX" Type="DMX512" ConductorAmount="3" Impedance="120">
    <PinPatch FromWiringObject="A" FromPin="4" ToWiringObject="B" ToPin="4" />
    <PinPatch FromWiringObject="A" FromPin="5" ToWiringObject="B" ToPin="5" />
    <PinPatch FromWiringObject="A" FromPin="6" ToWiringObject="B" ToPin="6" />
  </Conductors>
</Cable>
```

## Cable definition MVR

```xml
  <Cable
    uuid="7C6B12E5-0AC9-45B2-99EA-5C7C9D9F5A10"
    name="Low Voltage PSU Feed 25m Hybrid"
    length="25.0"
    GDTFSpec="MyFixtureFamily.gdtf"
    GDTFMode="DMX cable">
  </Cable>
```
Example cable utilization:

```xml
<Connection
  own="LowVoltageOutput"
  other="LowVoltageInput"
  toObject="..."
  cable="7C6B12E5-0AC9-45B2-99EA-5C7C9D9F5A10"/>
<Connection
  own="LowVoltageOutput"
  other="LowVoltageInput"
  toObject="..."
  cable="7C6B12E5-0AC9-45B2-99EA-5C7C9D9F5A10"/>
```
