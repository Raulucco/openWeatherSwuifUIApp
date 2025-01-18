//
//  MainRoutes.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 29.12.2024.
//

import CoreLocation
import Foundation

enum MainRoutes: Hashable {
    case settings(apiKeyManager: ApiManager)
    case locationPicker
    case weatherStatus(location: CLLocationCoordinate2D)

    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.settings(let lhsApiManager), .settings(let rhsApiManager)):
            return lhsApiManager.value == rhsApiManager.value
        case (.locationPicker, .locationPicker):
            return true
        case (.weatherStatus(let lhsLocation), .weatherStatus(let rhsLocation)):
            return lhsLocation.latitude == rhsLocation.latitude
                && lhsLocation.longitude == rhsLocation.longitude
        default:
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .settings(let apiKeyManager):
            hasher.combine(apiKeyManager.value)
        case .locationPicker: hasher.combine(1)
        case .weatherStatus(let location):
            hasher.combine(location.latitude)
            hasher.combine(location.longitude)
        }
    }
}
