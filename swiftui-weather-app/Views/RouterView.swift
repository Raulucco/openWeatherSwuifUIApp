//
//  RouterView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 29.12.2024.
//

import SwiftUI
import CoreLocation

struct RouterView: View {
    @StateObject private var mainRouter = MainRouterCoordinator.shared
    @StateObject private var apiManager = ApiManager.shared
    private var coordinator: LocationRouterCoordinator = LocationRouterCoordinator(parent: MainRouterCoordinator.shared)

    var body: some View {
        
        NavigationStack(path: $mainRouter.navigationPath) {
            mainRouter.loadView(route: .settings(apiKeyManager: apiManager)).navigationDestination(for: Routes.self) { route in
                mainRouter.loadView(route: route)
            }.navigationDestination(for: LocationRoutes.self) { route in
                coordinator.loadView(route: route)
            }
        }
    }
}
