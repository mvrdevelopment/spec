# Tracking Proposal

We will support tracking systems with new attributes. By default it is intended that the tracking info will be a child of the fixture it is for. This uses the Kinematic Chain feature from MVR.

![Kinematic Chain](./KinematicChain.png)

On the control side, you can use the encoders to group the properties also of the child fixtures.

![ControlSide](./ControlSide.png)

| Attribute  | Description  | What will happen in visualizers  | What the Physical Value will mean  |
|---|---|---|---|
| TrackerID  | Defines the tracker ID that be used as a target for the fixture.   | The fixture that is the parent of the tracker fixture, will point to the tracker with the given ID.   | The Physical Value will be interpreted as an integer ID with rounding.   |
| TrackerCrossFade  | Defines how the value for the position and rotation of the device are calcualted. 0% means fully from the device, 100% means fully from the tracker position.  |    |
| TrackerTime  |   |    |
| TrackerOffsetX  | Defines the offset in X direction the device will point in relation the the actual tracker position.  |    | In the global coordinate system the tracking target will offsetted with in X direction.  | 
| TrackerOffsetY  | Defines the offset in Y direction the device will point in relation the the actual tracker position.  |    | In the global coordinate system the tracking target will offsetted with in X direction.| 
| TrackerOffsetZ  | Defines the offset in Z direction the device will point in relation the the actual tracker position.  |    | In the global coordinate system the tracking target will offsetted with in X direction. | 
| TrackerMode  | Defines settings that you can make for the device and the tracker that is assigned to the device.  |    |
| TrackerControlHeight  | Allows to define the offset in Z direction that the tracker will have for all devices using this tracker for positioning.  |    |
| TrackerControlSpeed  | Defines how fast the device reacts to changes in the position of the tracker.  |    |
| TrackerControlFreeze  | Defines how accurate the device reacts to changes in the position of the tracker.  |    |
| TrackerControlBeamSize  | Defines how big the beam size for the fixture should be.   |    |
| TrackerControlMode  | Defines settings that you can make to the tracker.  |    |
| TrackerControlShow  | Defines settings that you can make to the show.  |    |


```xml
   <AttributeDefinitions>  
       <ActivationGroups>  
           ... 
           <ActivationGroup  Name="Tracking" />  
       </ActivationGroups>  
       <FeatureGroups>  
        ...
           <FeatureGroup  Name="Tracking">  
               <Feature  Name="Tracking" />  
               <Feature  Name="TrackingControl" />  
           </FeatureGroup>  
       </FeatureGroups>  
       <Attributes>  
           <Attribute Name="TrackerID" Pretty="ID" Feature="Tracking.Tracking" PhysicalUnit="None"/>  
           <Attribute Name="TrackerCrossFade" Pretty="Cross Fade" Feature="Tracking.Tracking" PhysicalUnit="Percent"/>  
           <Attribute Name="TrackerTime" Pretty="Tine" Feature="Tracking.Tracking" PhysicalUnit="Time"/>  
           <Attribute Name="TrackerOffsetX" Pretty="Offset X" Feature="Tracking.Tracking" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerOffsetY" Pretty="Offset Y" Feature="Tracking.Tracking" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerOffsetZ" Pretty="Offset Z" Feature="Tracking.Tracking" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerMode" Pretty="Mode" Feature="Tracking.Tracking" PhysicalUnit="None"/>  

           <Attribute Name="TrackerControlHeight" Pretty="Height" Feature="Tracking.TrackingControl" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerControlSpeed" Pretty="Speed" Feature="Tracking.TrackingControl" PhysicalUnit="Speed"/>  
           <Attribute Name="TrackerControlFreeze" Pretty="Freeze" Feature="Tracking.TrackingControl" PhysicalUnit="Percent"/>  
           <Attribute Name="TrackerControlBeamSize" Pretty="Beam Size" Feature="Tracking.TrackingControl" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerControlMode" Pretty="Control Mode" Feature="Tracking.TrackingControl" PhysicalUnit="None"/>  

           <Attribute Name="TrackerControlShow" Pretty="Show Mode" Feature="Tracking.TrackingControl" PhysicalUnit="None"/>  
       </Attributes>  
   </AttributeDefinitions>
```