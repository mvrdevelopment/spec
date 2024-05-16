


```xml
   <AttributeDefinitions>  
       <ActivationGroups>  
           ... 
           <ActivationGroup  Name="Shaper" />  
       </ActivationGroups>  
       <FeatureGroups>  
        ...
           <FeatureGroup  Name="Tracking">  
               <Feature  Name="Tracking" />  
               <Feature  Name="TrackingControl" />  
           </FeatureGroup>  
       </FeatureGroups>  
       <Attributes>  
           <Attribute Name="TrackerID" Pretty="TID" Feature="Tracking.Tracking" PhysicalUnit="None"/>  
           <Attribute Name="TrackerCrossFade" Pretty="" Feature="Tracking.Tracking" PhysicalUnit="Percent"/>  
           <Attribute Name="TrackerTime" Pretty="Dim" Feature="Tracking.Tracking" PhysicalUnit="Time"/>  
           <Attribute Name="TrackerOffsetX" Pretty="Dim" Feature="Tracking.Tracking" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerOffsetY" Pretty="Dim" Feature="Tracking.Tracking" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerOffsetZ" Pretty="Dim" Feature="Tracking.Tracking" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerMode" Pretty="Dim" Feature="Tracking.Tracking" PhysicalUnit="None"/>  

           <Attribute Name="TrackerControlHeight" Pretty="Dim" Feature="Tracking.TrackingControl" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerControlSpeed" Pretty="Dim" Feature="Tracking.TrackingControl" PhysicalUnit="Speed"/>  
           <Attribute Name="TrackerControlFreeze" Pretty="Dim" Feature="Tracking.TrackingControl" PhysicalUnit="None"/>  
           <Attribute Name="TrackerControlBeamSize" Pretty="Dim" Feature="Tracking.TrackingControl" PhysicalUnit="Length"/>  
           <Attribute Name="TrackerControlMode" Pretty="Dim" Feature="Tracking.TrackingControl" PhysicalUnit="None"/>  

           <Attribute Name="TrackerControlShow" Pretty="Dim" Feature="Tracking.TrackingControl" PhysicalUnit="None"/>  
       </Attributes>  
   </AttributeDefinitions>
```