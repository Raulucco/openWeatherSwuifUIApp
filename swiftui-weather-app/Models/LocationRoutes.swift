//
//  LocationRoutes.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 30.12.2024.
//

import Foundation

enum LocationRoutes: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case /*(.home, .home), */(.map, .map):
            return true
        case (.parent(let lhsRoute), .parent(let rhsRoute)):
            return lhsRoute == rhsRoute
        default:
            return false
        }
    }
    
    case /*home,*/ map, parent(route: Routes)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
//        case .home: hasher.combine(0)
        case .map: hasher.combine(0)
        case .parent(let route):
            route.hash(into: &hasher)
        }
    }
    
}
