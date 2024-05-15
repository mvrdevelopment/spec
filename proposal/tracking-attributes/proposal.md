


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
           <Attribute Name="TrackerID" Pretty="Dim" Feature="Tracking.Tracking" />  
           <Attribute Name="TrackerCrossFade" Pretty="Dim" Feature="Tracking.Tracking" />  
           <Attribute Name="TrackerTime" Pretty="Dim" Feature="Tracking.Tracking" />  
           <Attribute Name="TrackerOffsetX" Pretty="Dim" Feature="Tracking.Tracking" />  
           <Attribute Name="TrackerOffsetY" Pretty="Dim" Feature="Tracking.Tracking" />  
           <Attribute Name="TrackerOffsetZ" Pretty="Dim" Feature="Tracking.Tracking" />  
           <Attribute Name="TrackerMode" Pretty="Dim" Feature="Tracking.Tracking" />  

           <Attribute Name="TrackerControlHeight" Pretty="Dim" Feature="Tracking.TrackingControl" />  
           <Attribute Name="TrackerControlSpeed" Pretty="Dim" Feature="Tracking.TrackingControl" />  
           <Attribute Name="TrackerControlFreeze" Pretty="Dim" Feature="Tracking.TrackingControl" />  
           <Attribute Name="TrackerControlBeamSize" Pretty="Dim" Feature="Tracking.TrackingControl" />  
           <Attribute Name="TrackerControlMode" Pretty="Dim" Feature="Tracking.TrackingControl" />  

           <Attribute Name="TrackerControlShow" Pretty="Dim" Feature="Tracking.TrackingControl" />  
       </Attributes>  
   </AttributeDefinitions>
```