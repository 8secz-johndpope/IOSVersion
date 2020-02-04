//
//  ServiceCategoryModel.swift
//  Worktide
//
//  Created by Kristofer Huang on 2019-12-23.
//  Copyright © 2019 Kristofer Huang. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import FirebaseFirestore
import FirebaseStorage

class ServiceCategoryModel:NSObject{
   
    var serviceTitle: String?
    var servicePay: String?
    var serviceID:String?
    var locationDistance:String?
    var duration:String?
    var latitude: Double?
    var longitude: Double?
    var circleRadius: Double?
    var creatorImage:UIImage?
    var creatorName:String?
    var creatorID:String?
    
    init(serviceTitle:String?, servicePay:String?, serviceID:String?, latitude: Double?, longitude: Double?, circleRadius:Double?, currentLocation:CLLocationCoordinate2D, duration:Int?, creatorImage:UIImage?, creatorName:String?, creatorID:String?) {
        super.init()
        self.serviceTitle = serviceTitle
        self.servicePay = "$" + servicePay!
        self.serviceID = serviceID
        self.latitude = latitude
        self.longitude = longitude
        self.circleRadius = circleRadius
        self.creatorID = creatorID
        
        
        //determine location of service
        let serviceLocation = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        if(circleRadius == 0){
            //if the service is a shop
            let distanceApart = currentLocation.distance(from: serviceLocation)
            self.locationDistance = "\(String(format:"%.2f", Double(distanceApart)/1000)) km away from you"
        } else {
            //service is location based
            let distanceApart = currentLocation.distance(from: serviceLocation)
            if(Double(distanceApart).isLess(than: circleRadius!)){
                //user inside of circle
                self.locationDistance = "This service will come to you."
            } else {
                //user is outside of circle
                self.locationDistance = "This service is not available in your location."
            }
        }
        
        //change string of time
        let time = minutesToHoursMinutes(minutes: duration!)
        let hour = time.hours
        let minutes = time.leftMinutes
        //set text
        if(hour == 0){
            self.duration = String(minutes) + " min"
        } else {
            if(hour == 1){
                self.duration = String(hour) + " hour " + String(minutes) + " min"
            } else {
                self.duration = String(hour) + " hours " + String(minutes) + " min"
            }
        }
        
        self.creatorName = creatorName
        self.creatorImage = creatorImage
        
    }
    
    func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    

}
