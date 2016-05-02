//
//  EventListTableViewController.swift
//  Sappenin
//
//  Created by Siddhant K Tandon on 4/22/16.
//  Copyright © 2016 Siddhant K Tandon. All rights reserved.
//

import UIKit
import MapKit


class EventListTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var allEvents = [Event]()
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    var cellIndexSelected: Int!
    
    @IBOutlet weak var byAttendanceButton: UIButton!
    @IBOutlet weak var byProximityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self //important!!
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()
        setUserDefaults()
        byAttendanceButton.selected = true
        
        byAttendanceButton.addTarget(self, action: "filterFunction:", forControlEvents: UIControlEvents.TouchUpInside)
        byProximityButton.addTarget(self, action: "filterFunction:", forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    func checkCoreLocationPermission() {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .Restricted {
            //put an alert and explain things here
            print("unauthorized to use location serivce")
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        locationManager.stopUpdatingLocation() //save battery
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUserDefaults() {
        
        let event1 = Event(name: "Mones' Palace", address: "2215 Channing Way, Berkeley CA, 94704", type: "Restaurant", description: "Spicy Indian Food place!. We got Karoke going on tonight, come join us! All ages are welcome!", thumbnailImageName: "avatar.png", attendants: 406, location: CLLocation(latitude: 37.866440, longitude: -122.264830), distanceFromCurrentLocation: 0, attendanceStatus: "Maybe")
        
        let event2 = Event(name: "Cheesecake Factory", address: "8th Floor, Macy's, 251 Geary St, San Francisco, CA 94102", type: "Restaurant", description: "20% off the entire bill in celebration of dead week. Show that you got to us through this app for a free cheesecake!", thumbnailImageName: "images.png", attendants: 311, location: CLLocation(latitude: 37.787293, longitude: -122.406009), distanceFromCurrentLocation: 0, attendanceStatus: "Maybe")
        let event3 = Event(name: "Party at Sid's", address: "2301 Durant Avenue, Berkeley CA, 94704", type: "Kickback", description: "Can't take anymore studying? Need a break? Sid's kickback is happening tonight! Bring your own friends, BYOB :)", thumbnailImageName: "party.jpg", attendants: 112, location: CLLocation(latitude: 37.866440, longitude: -122.264830), distanceFromCurrentLocation: 0, attendanceStatus: "Maybe")
        let event4 = Event(name: "Star Watching Party", address: "Golden Gate Bridge", type: "Stargazing", description: "The star watchers association are meeting at the coolest location this year, the Golden Gate Bridge!", thumbnailImageName: "golden-gate-bridge.jpeg", attendants: 87, location: CLLocation(latitude: 37.819863, longitude:  -122.474123), distanceFromCurrentLocation: 0, attendanceStatus: "Maybe")
        
        allEvents.append(event1)
        allEvents.append(event2)
        allEvents.append(event3)
        allEvents.append(event4)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "eventViewSegue") {
            let svc = segue.destinationViewController as! EventViewController
            let indexPath = tableView.indexPathForSelectedRow
            cellIndexSelected = (indexPath?.row)!
            let event = allEvents[(indexPath?.row)!]
            svc.currentLocation = currentLocation
            svc.locationOfEvent = event.location
            svc.eventName = event.name
            svc.eventAddress = event.address
            svc.distanceFromCurrentLocation = event.distanceFromCurrentLocation
            svc.eventType = event.type
            svc.eventDescription = event.description
            svc.eventAttendants = event.attendants
            svc.attendanceStatus = event.attendanceStatus
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allEvents.count
    }
 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventTableViewCell
        let entry = allEvents[indexPath.row]
        cell.eventNameLabel.text = entry.name
        cell.eventDescriptionLabel.text = entry.description
        cell.eventThumbnailImage.image = UIImage(named: entry.thumbnailImageName)
        cell.eventTypeLabel.text = entry.type
        
        if let location = currentLocation {
            entry.distanceFromCurrentLocation = round(100*0.000621371*location.distanceFromLocation(entry.location))/100
            cell.distanceFromCurrentLocationLabel.text = String(entry.distanceFromCurrentLocation) + " mi."
        }

        return cell
    }
    
    @IBAction func unwindToEventListTableViewController(segue: UIStoryboardSegue) {
        let svc = segue.sourceViewController as! EventViewController
        let entry = allEvents[cellIndexSelected]
        entry.attendants = svc.eventAttendants
        entry.attendanceStatus = svc.attendanceStatus
    }
    
    func filterFunction(sender:UIButton) {
        if (sender.currentTitle == "By Attendance") {
            allEvents.sortInPlace { (event1:Event, event2:Event) -> Bool in
                event1.attendants > event2.attendants
            }
            byAttendanceButton.selected = true
            byProximityButton.selected = false
        } else {
            allEvents.sortInPlace { (event1:Event, event2:Event) -> Bool in
                event1.distanceFromCurrentLocation < event2.distanceFromCurrentLocation
            }
            byAttendanceButton.selected = false
            byProximityButton.selected = true
        }
        self.tableView.reloadData()
    }

}
