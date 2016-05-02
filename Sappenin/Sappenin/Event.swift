//
//  Event.swift
//  Sappenin
//
//  Created by Siddhant K Tandon on 4/22/16.
//  Copyright © 2016 Siddhant K Tandon. All rights reserved.
//

import UIKit
import MapKit

class Event {
    
    var name:String
    var address:String
    var type:String
    var description:String
    var thumbnailImageName:String
    var attendants:Int
    var location:CLLocation
    var distanceFromCurrentLocation:Double
    var attendanceStatus:String
    
    init(name:String, address:String, type:String, description:String, thumbnailImageName:String, attendants:Int, location: CLLocation, distanceFromCurrentLocation:Double, attendanceStatus: String) {
        
        self.name = name
        self.address = address
        self.type = type
        self.description = description
        self.thumbnailImageName = thumbnailImageName
        self.location = location
        self.attendants = attendants
        self.distanceFromCurrentLocation = distanceFromCurrentLocation
        self.attendanceStatus = attendanceStatus
        
    }
}
