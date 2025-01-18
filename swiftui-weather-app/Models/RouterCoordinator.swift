//
//  RouterCoordinator.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 29.12.2024.
//

import Foundation
import SwiftUI

protocol RouterCoordinator<R>: ObservableObject where R == MainRoutes {
    associatedtype R
    var navigationPath: NavigationPath { get set }
    func navigate(to route: R)
    func navigateBack()
    func navigateToRoot()
}

extension RouterCoordinator {
    @ViewBuilder
    func loadView(route: R) -> some View {
        EmptyView()
    }
}

class MainRouterCoordinator: RouterCoordinator {
    typealias R = MainRoutes

    @Published
    var navigationPath = NavigationPath()

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
            LoadWeatherAtView(path: self, location: location)
        case .locationPicker:
            LocationView()
        }
    }
}

class LocationRouterCoordinator: ObservableObject, RouterCoordinator {
    var navigationPath: NavigationPath

    @Published
    var parentCoordinator: MainRouterCoordinator

    private var childRoutesDeep = 0

    init(parent: MainRouterCoordinator) {
        self.parentCoordinator = parent
        navigationPath = parent.navigationPath
    }

    func navigate(to route: LocationRoutes) {
        switch route {
        case .parent(let parentRoute):
            navigate(to: parentRoute)
        default:
            childRoutesDeep += 1
            parentCoordinator.navigationPath.append(route)
        }
    }

    func navigate(to route: MainRoutes) {
        parentCoordinator.navigationPath.removeLast(childRoutesDeep)
        childRoutesDeep = 0
        parentCoordinator.navigate(to: route)
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
        case .map:
            LocationSelectorView(routerCoordinator: self)
        case .parent(let route):
            parentCoordinator.loadView(route: route)
        }
    }
}
