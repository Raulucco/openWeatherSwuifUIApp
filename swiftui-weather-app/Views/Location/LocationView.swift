//
//  LocationView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 30.12.2024.
//

import SwiftUI

struct LocationView: View {
    private var coordinator: LocationRouterCoordinator = LocationRouterCoordinator(parent: MainRouterCoordinator())
    
    var body: some View {
        LocationPickerView(routerCoordinator: coordinator)
    }
}
