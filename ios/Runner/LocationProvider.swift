//
// Created by rx on 25/02/2017.
// Copyright (c) 2017 The Chromium Authors. All rights reserved.
//

import Foundation
import CoreLocation
import Flutter

class LocationProvider: NSObject, FlutterMessageListener, CLLocationManagerDelegate {
    var messageName: String = "getLocation"
    let manager:CLLocationManager

    override init() {
        print("=> LocationProvider init...")
        messageName = "getLocation"
        manager = CLLocationManager()

    }

    func didReceive(_ message: String!) -> String! {
        print("=> LocationProvider -> didReceive )")

        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.delegate = self
            manager.requestWhenInUseAuthorization()
        } else if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()

            if let location = manager.location {
                let resp = ["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude, "status":1]
                do {
                    let data = try JSONSerialization.data(withJSONObject: resp)
                    let response = String(data: data, encoding: String.Encoding.utf8)
                    print("=> LocationProvider -> no location \(String(data: data, encoding: String.Encoding.utf8))")
                    return response
                } catch {
                    print("=> LocationProvider -> ERROR")
                    return "{\"latitude\":0,\"longitude\":0, \"status\":0}"
                }
            }
        }

        print("=> LocationProvider -> no location")
        return "{\"latitude\":0,\"longitude\":0, \"status\":-1}"
    }

    func locationManager(manager:CLLocationManager, didChangeAuthorizationStatus status:CLAuthorizationStatus){
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            manager.startUpdatingLocation()
        }
    }

}
