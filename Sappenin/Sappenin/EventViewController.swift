//
//  EventViewController.swift
//  Sappenin
//
//  Created by Siddhant K Tandon on 4/23/16.
//  Copyright © 2016 Siddhant K Tandon. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

class EventViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var currentLocation: CLLocation!
    var locationOfEvent: CLLocation!
    var eventName: String!
    var eventAddress: String!
    var distanceFromCurrentLocation: Double!
    var eventType: String!
    var eventDescription:String!
    var eventAttendants:Int!
    var attendanceStatus:String!
    
    var destination:MKMapItem = MKMapItem()
    
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var eventAttendantsLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var distanceFromCurrentLocationLabel: UILabel!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var maybeButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var rsvpMessageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setupMapView()
        yesButton.addTarget(self, action: "toggleAttendance:", forControlEvents: UIControlEvents.TouchUpInside)
        maybeButton.addTarget(self, action: "toggleAttendance:", forControlEvents: UIControlEvents.TouchUpInside)
        noButton.addTarget(self, action: "toggleAttendance:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabels() {
        eventNameLabel.text = eventName
        eventTypeLabel.text = eventType
        eventDescriptionLabel.text = eventDescription
        eventAttendantsLabel.text = "Attendants:  " + String(eventAttendants)
        if let _ = currentLocation, locOfEvent = locationOfEvent {
            distanceFromCurrentLocationLabel.text = String(distanceFromCurrentLocation) + " mi."
            let placemark = MKPlacemark(coordinate: locOfEvent.coordinate, addressDictionary: nil)
            
            destination = MKMapItem(placemark: placemark)
        }
        
        if attendanceStatus == "Yes" {
            yesButton.selected = true
            maybeButton.selected = false
            noButton.selected = false
            rsvpMessageLabel.text = "Yayyy, can't wait to see you there"
        } else if attendanceStatus == "Maybe" {
            yesButton.selected = false
            maybeButton.selected = true
            noButton.selected = false
            rsvpMessageLabel.text = "Come on, just say yes! Do you really have a better event to go to?"
        } else {
            yesButton.selected = false
            maybeButton.selected = false
            noButton.selected = true
            rsvpMessageLabel.text = "Aww, thats too bad. Maybe next time!"
        }
        
    }
    
    
    
    
    func setupMapView() {
        
        if let curLoc = currentLocation, eventLoc = locationOfEvent {
            let initialCenteredLocation = CLLocation(latitude: (curLoc.coordinate.latitude + eventLoc.coordinate.latitude)/2, longitude: (eventLoc.coordinate.longitude + curLoc.coordinate.longitude)/2)
            let regionRadius = CLLocationDistance(1.2 * Double(distanceFromCurrentLocation) * 1609.34)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialCenteredLocation.coordinate,
                                                                      regionRadius, regionRadius)
            
            mapView.setRegion(coordinateRegion, animated: true)
            let annotation1 = MKPointAnnotation()
            annotation1.coordinate = curLoc.coordinate
            annotation1.title = "Current Location"
            
            let annotation2 = MKPointAnnotation()
            annotation2.coordinate = eventLoc.coordinate
            annotation2.title = eventName
            annotation2.subtitle = eventType
            mapView.addAnnotation(annotation1)
            mapView.addAnnotation(annotation2)
            mapView.showAnnotations([annotation1, annotation2], animated: true)
            
        }
        
    }
    
    @IBAction func getDirections(sender: AnyObject) {
        let options = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        
        destination.openInMapsWithLaunchOptions(options)
    }
    
    func toggleAttendance(sender:UIButton) {
        if sender.currentTitle == "Yes" {
            if yesButton.selected == false {
                eventAttendants = eventAttendants + 1
            }
            yesButton.selected = true
            maybeButton.selected = false
            noButton.selected = false
            rsvpMessageLabel.text = "Yayyy, can't wait to see you there"

        } else if sender.currentTitle == "Maybe" {
            if yesButton.selected == true {
                eventAttendants = eventAttendants - 1
            }
            yesButton.selected = false
            maybeButton.selected = true
            noButton.selected = false
            rsvpMessageLabel.text = "Come on, just say yes! Do you really have a better event to go to?"
        } else {
            if yesButton.selected == true {
                eventAttendants = eventAttendants - 1
            }
            yesButton.selected = false
            maybeButton.selected = false
            noButton.selected = true
            rsvpMessageLabel.text = "Aww, thats too bad. Maybe next time!"
        }
        eventAttendantsLabel.text = "Attendants:  " + String(eventAttendants)
        attendanceStatus = sender.currentTitle
    }
    
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
