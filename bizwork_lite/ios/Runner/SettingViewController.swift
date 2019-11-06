//
//  SettingViewController.swift
//  Runner
//
//  Created by ADMIN on 11/5/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import UserNotifications

//https://www.raywenderlich.com/5817-background-modes-tutorial-getting-started
//https://medium.com/@calvinlin_96474/ios-11-continuous-background-location-update-by-swift-4-12ce3ac603e3
class SettingViewController: UIViewController {
    
    private var locations: [MKPointAnnotation] = []

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.pausesLocationUpdatesAutomatically = false
        manager.requestAlwaysAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func stop_Action(_ sender: Any) {
        locationManager.stopUpdatingLocation()
    }
    
    
    @IBAction func start_Action(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    

    @IBAction func back_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - CLLocationManagerDelegate
extension SettingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        // Add another annotation to the map.
        let annotation = MKPointAnnotation()
        annotation.coordinate = mostRecentLocation.coordinate
        
        // Also add to our map so we can remove old values later
        self.locations.append(annotation)
        
        // Remove values if the array is too big
        while locations.count > 100 {
            let annotationToRemove = self.locations.first!
            self.locations.remove(at: 0)
        }
        
        let content = UNMutableNotificationContent()
        content.title = "App is backgrounded"
        content.body = "New location is \(mostRecentLocation)"
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
