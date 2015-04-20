//
//  MapViewController.swift
//  Hackathon
//
//  Created by Huibo Li on 4/17/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
               CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error)
            -> Void in
            if error != nil {
                println("Error:"+error.localizedDescription)
                return
            }
            
            if placemarks.count>0{
                let pm=placemarks[0] as! CLPlacemark
                self.displayLoactionInfo(pm)
            }
            else{
                println("error with data")
            }
            
        })
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error: "+error.localizedDescription)
    }
    
    func displayLoactionInfo(placemark:CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.administrativeArea)
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
