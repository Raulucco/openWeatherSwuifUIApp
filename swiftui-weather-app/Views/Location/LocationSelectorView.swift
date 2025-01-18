//
//  OpenMapView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 29.12.2024.
//

import SwiftUI
import MapKit

struct LocationSelectorView: View {
    var routerCoordinator: LocationRouterCoordinator
    
    @State private var location: CLLocationCoordinate2D?
    @State private var isLocationAlertPresented = false
    @State private var placemark: CLPlacemark?
    
    var body: some View {
        MapReader { proxy in
            Map().onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        print(coordinate)
                        location = coordinate
                        
                        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) {  placemark, error in
                            guard let placemark = placemark?.first else {
                                return
                            }
                            
                            
                            self.placemark = placemark
                            self.isLocationAlertPresented = true
                        }
                        
                    }
                }
        }.alert(isPresented: $isLocationAlertPresented) {
            var alertMessage = "latitude: \(self.location?.latitude)\tlongitude: \(self.location?.longitude)"
            
            if let placemark = self.placemark {
                alertMessage = ""
                if let city = placemark.locality {
                    
                }
            }
            
            return Alert(
                title: Text("Would you like to use selected location?"),
                message: Text(alertMessage),
                primaryButton: .default(Text("Use location"), action: {
                
                    guard let location = self.location else {
                        return
                    }
                    self.isLocationAlertPresented = false

                    self.routerCoordinator.navigate(to: .parent(route: .weatherStatus(location: location)))
                }),
                secondaryButton: .cancel(Text("Cancel"), action: {
                    self.isLocationAlertPresented = false
                    self.location = nil
                })
            )
            
        }
    }
}
