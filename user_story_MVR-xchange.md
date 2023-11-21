
## The Idea of MVR-xchange Communication
The MVR exchange protocol should define an online or "on the wire" protocol to exchange MVR files in a network environment. Technically it should replace the USB-stick or file-saving process for an easier update of MVR changes within a working group. There are two basic use-cases to look at to define the goal of MVR exchange:

### Small Setup
One Programmer/Operator using a lighting desk, one or two visualizers and an appropriate planning software. Most likely all computers running the different applications are connected via a switch and are within reach. It would be no problem to use a USB-Stick to exchange files. But it would simplify the workflow by using MVR-exchange protocol because all machines are located and connected “automatically” and the exported files will be shared with all applications. The user still needs to change keyboard & mouse to control each application individually but that is a known “workflow limitation” as it applies for using the different applications anyway.
 
#### Advantages of this workflow
- No need to plug in a USB stick several times.
- No need to manually copy the files into the correct folder on different computers.
 
#### Add on
If an external person such as a planner or logistic person joins the network, they can instantly exchange the latest MVR files. Following the logic, the system of MVR-exchange can grow and be expanded dynamically.
 
### Large Setup
Multiple consoles each with a visualizer station, a tracking system, a planner, some media server in a rack and a lighting designer sharing a (pre-) programming room. All applications running on different computers are connected via network. One operator per station working locally with the visualizer while all other stations are manned by specialists.
Many stations need to be able to read and write MVR files to keep track of the current changes in the show. Most likely each and one needs to update at a different time due to the local workload and progress.
 
#### Advantages of this workflow
- No need to plug in a USB stick many times.
- No need to manually copy the files into the correct folder on different computers.
- Tracking of latest changes should be easier as in the network the files arrive in logical (timed) order.

### Rules that need to apply for the workflows described.
- The stations that handle MVR files need to find each other “automatically”.
- The stations will handle leaving/adding stations “automatically”.
- Data exchange will be initiated by a user pushing the button “MVR export”.
- All participating stations will be notified that a new MVR file is available.
- The file will be saved locally and will be transmitted to the joined stations in the network (that requested it).
- The file will be made available to all other stations in the network.
- The local user will be informed that a new file is available for import.
  
### What MVR-exchange cannot do!
- There are no live updates of changes.
- There is no rule to always import all changes – ergo: there is no single file or source of truth.
- There is no offline update for stations joining later or leaving earlier.
- There is (currently) no way to connect stations via internet.


### Possible process of communication
Every application can join a particular "MVR-xchange Group" to separate between different working groups within one network. This will be a setting within the application and transmitted during the Discovery process.
Discovery will be executed by mDNS and by the rule-set of station priority the highest priority will create a Websocket Server and all other devices of the same "MVR-xchange Group" will be able to communicate with the server. Once a user decides to export an MVR file with the current changes the information will be distributed via the Server to all applications. Each station has the option to decide to request an MVR-file as well. At least the server should hold the latest MVR files available. 
Suggested communication messages are still work in progress...





