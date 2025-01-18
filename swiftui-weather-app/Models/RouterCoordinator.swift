//
//  RouterCoordinator.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 29.12.2024.
//

import Foundation
import SwiftUI

protocol RouterCoordinator<R>: ObservableObject {
    associatedtype R
    var navigationPath: NavigationPath { get set }
    func navigate(to route: R)
    func navigateBack()
    func navigateToRoot()
}

class MainRouterCoordinator: RouterCoordinator {
    typealias R = Routes
    @Published
    var navigationPath = NavigationPath()
    
    static let shared = MainRouterCoordinator()
    
    private init() {}
    
    func navigate(to route: R) {
        navigationPath.append(route)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    @ViewBuilder
    func loadView(route: R) -> some View {
        switch route {
        case .settings(let apiKeyManager):
             SettingsView(path: self, apiKeyManager: apiKeyManager)
        case .weatherStatus(let location):
             LoadWeatherAtView(path: self, location: location, apiKey: "")
        case .locationPicker:
             LocationView()
        }
    }
}


class LocationRouterCoordinator: ObservableObject {
    @Published
    var parentCoordinator: MainRouterCoordinator
    
    private var childRoutesDeep = 0
    
    init(parent: MainRouterCoordinator = MainRouterCoordinator.shared) {
        self.parentCoordinator = parent
    }
            
    func navigate(to route: LocationRoutes) {
        switch route {
        case .parent(let parentRoute):
            parentCoordinator.navigationPath.removeLast(childRoutesDeep)
            childRoutesDeep = 0
            parentCoordinator.navigate(to: parentRoute)
        default:
            childRoutesDeep += 1
            parentCoordinator.navigationPath.append(route)
        }
    }
    
    func navigateBack() {
        parentCoordinator.navigateBack()
    }
    
    func navigateToRoot() {
        parentCoordinator.navigateToRoot()
    }
    
    @ViewBuilder
    func loadView(route: LocationRoutes) -> some View {
        switch route {
//        case .home:
//            LocationPickerView(routerCoordinator: self)
        case .map:
            LocationSelectorView(routerCoordinator: self)
        case .parent(route: let route):
            parentCoordinator.loadView(route: route)
        }
    }
}




