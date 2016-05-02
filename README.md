# Sappenin'

## Authors

Siddhant K Tandon

## Purpose

Ever been sitting on home on a Friday night and had no idea what to do? Sappenin' helps you make your plan by telling you Whats Happening around you. It gives you a list of places/restaurants that are having a fun event/special deal at that time. It also allows you to see how popular that place will be, so going so you can have plan accordingly!

## Features

1. Check out deals/events that are taking place that night.
2. Filter by the number of people going to an event.
3. Get a summary of the location you're planning to visit.
4. Filter by distance.
6. Present a map view of the place in a 'map view' and a 'Get Me Directions' button to route using Apple Maps.
7. Advertise your own event on the app.

## Control Flow

Users are initially presented with a splash screen, where they can log in or browse as a guest. Once done, a table view of all the exciting things/events happening around them is presented to them. They can click on a location/event and view a summary of the place/restaurant where special deals shall be listed. You can see the number of people who are going, and confirm whether you shall also be going. There will be a touch to navigate button where you can get to the place using Apple Maps.

## Implementation

### Model

1. Event.Swift

### View

1. EventTableViewCell

### Controller

1. EventListTableViewController
2. EventViewController

