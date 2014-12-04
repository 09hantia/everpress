//
//  SenderLocationViewController.swift
//  everpress
//
//  Created by Tianfei Han on 14-11-30.
//  Copyright (c) 2014年 Tianfei Han. All rights reserved.
//

import UIKit
import CoreLocation

class SenderLocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    var locationManager: CLLocationManager!
    
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        locationUpdateScheduler()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Location Manager helper stuff
    func initLocationManager() {
        let seenError = false
        locationManager = CLLocationManager()
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            
            locationManager.requestWhenInUseAuthorization();
        }
        //locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.startUpdatingLocation()
        
        
    }
    
    // Location Manager Delegate stuff
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as CLLocation
            var coord = locationObj.coordinate
            
            
            
            var currentLat: String = "\(manager.location.coordinate.latitude)"
            var currentLng: String = "\(manager.location.coordinate.longitude)"
            longtitudeLabel.text = currentLat
            latitudeLabel.text = currentLng
            
            
            println(currentLat)
            println(currentLng)
            println(coord.latitude)
            println(coord.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                locationManager.startUpdatingLocation()
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
    }

    
    func locationUpdateScheduler(){
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("handleTimer:"), userInfo: nil, repeats: true)
    }
    
    func handleTimer(timer: NSTimer){
        locationManager.startUpdatingLocation()
        longtitudeLabel.text = String(format: "%f",locationManager.location.coordinate.longitude)
        latitudeLabel.text = String(format: "%f",locationManager.location.coordinate.latitude)

        println("location latitude: \(locationManager.location.coordinate.latitude)")
        println("location longtitude: \(locationManager.location.coordinate.longitude)")
        println("called")

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
