//
//  LocationPickerView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 29.12.2024.
//

import SwiftUI
import CoreLocationUI
import CoreLocation

struct LocationPickerView: View {
    var routerCoordinator: LocationRouterCoordinator
    
    @StateObject  private var userLocation = UserLocation()
    
    private var location: CLLocationCoordinate2D? { get { userLocation.location } }


    var body: some View {
        Spacer()

        LocationButton {
            userLocation.requestLocation()
        }.symbolVariant(.fill)
        .labelStyle(.titleAndIcon)
                
        Text("Or").padding()
        
        Button(action: {
            routerCoordinator.navigate(to: .map)
        }, label: {
            Text("Pick a location on the map")
        })
        
        Spacer()
        
        if let latitude = location?.latitude, let longitude = location?.longitude {
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Text("Latitude: ")
                    Text("\(latitude)") // TODO: Format nicelly
                }
                
                HStack {
                    Text("Longitude: ")
                    Text("\(longitude)") // TODO: Format nicelly
                }
            }
            
            Button(action: {
                guard let location = location else { return }
                routerCoordinator.navigate(to: .parent(route: .weatherStatus(location: location)))
            }, label: {
                Text("Use the selected location")
            }).disabled(location == nil)
        }

    }

}

#Preview {
    LocationPickerView(routerCoordinator: LocationRouterCoordinator(parent: MainRouterCoordinator.shared))
}
