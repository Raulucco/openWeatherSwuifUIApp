//
//  LocationRoutes.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 30.12.2024.
//

import Foundation

enum EmbededRoutes<T> {
    typealias Parent = T
    case parent(route: T)
}

enum LocationRoutes: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.map, .map):
            return true
        case (.parent(let lhsRoute), .parent(let rhsRoute)):
            return lhsRoute == rhsRoute
        default:
            return false
        }
    }

    case map
    case parent(route: MainRoutes)

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .map: hasher.combine(0)
        case .parent(let route):
            route.hash(into: &hasher)
        }
    }

}
