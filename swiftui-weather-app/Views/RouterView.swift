//
//  RouterView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 29.12.2024.
//

import CoreLocation
import SwiftUI

struct RouterView: View {
    @StateObject private var mainRouter = MainRouterCoordinator()
    @StateObject private var apiManager = ApiManager(apiKeyName: "API_KEY")
    private var coordinator: LocationRouterCoordinator =
        LocationRouterCoordinator(parent: MainRouterCoordinator())

    var body: some View {

        NavigationStack(path: $mainRouter.navigationPath) {
            mainRouter.loadView(route: .settings(apiKeyManager: apiManager))
                .navigationDestination(for: MainRoutes.self) { route in
                    mainRouter.loadView(route: route)
                }.navigationDestination(for: LocationRoutes.self) { route in
                    coordinator.loadView(route: route)
                }
        }.environmentObject(apiManager)
    }
}
