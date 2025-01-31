//
//  UserLocation.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 20.12.2024.
//

import CoreLocation
import Foundation

class UserLocation: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()

    @Published
    var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(
        _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        guard let currentLocation = locations.first?.coordinate else {
            return
        }
        location = currentLocation
    }

    func locationManager(
        _ manager: CLLocationManager, didFailWithError error: any Error
    ) {
        print(error)
    }
}
