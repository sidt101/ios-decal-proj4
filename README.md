<snippet>
  <content>
# Sappenin'
## Authors
Siddhant K Tandon
## Purpose
Ever been sitting on home on a Friday night and had no idea what to do? Sappenin' helps you make your plan by telling you Whats Happening around you. It gives you a list of places/restaurants that are having a fun event/special deal at that time. It also allows you to see how popular that place will be, so going so you can have plan accordingly!
## Features
* Check out deals/events that are taking place that night.
* Filter by the number of people going to an event.
* Get a summary of the location you're planning to visit.
* Filter by distance.
* Filter by the type of outing.
* Present places in a 'map view' and a 'Touch to Navigate' button to route using Maps.
* Advertise your own event on the app.
## Control Flow
Users are initially presented with a splash screen, where they can log in or browse as a guest. Once done, a table view of all the exciting things/events happening around them is presented to them. A user can toggle to the map view where nearby locations are presented to them. They can click on a location/event and view a summary of the place/restaurant where special deals shall be listed. You can see the number of people who are going, and confirm whether you shall also be going.
## Implementation
### Model
1. Event.Swift
2. User.swift
### View
1. EventListTableView
2. EventListMapView
3. EventView
4. DistanceToLocationView
### Controller
1. EventListTableViewController
2. EventListMapViewController
3. EventViewController
4. DistanceToLocationViewController
5. AddEventViewController
</content>
  <tabTrigger></tabTrigger>
</snippet>