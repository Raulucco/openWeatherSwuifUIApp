//
//  ApiManager.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 22.12.2024.
//

import Foundation

protocol SettingsManager<V>: ObservableObject {
    associatedtype V
    var value: V { get set }
}

class ApiManager: SettingsManager {
    typealias V = String
    private let userDefaults: UserDefaults
    private let environment: [String: String]  // ProcessInfo.processInfo.environment
    private let apiKeyName: String

    @Published
    var apiKey: V? {
        didSet {
            if let apiKey = apiKey {
                userDefaults.set(apiKey, forKey: apiKeyName)
            }
        }
    }

    var value: V {
        get {
            apiKey ?? userDefaults.string(forKey: apiKeyName) ?? environment[
                apiKeyName] ?? ""
        }
        set {
            apiKey = newValue
        }
    }

    init(
        apiKeyName: String, userDefaults: UserDefaults = .standard,
        environment env: [String: String] = [String: String]()
    ) {
        self.apiKeyName = apiKeyName
        self.userDefaults = userDefaults
        self.apiKey = userDefaults.string(forKey: apiKeyName)
        self.environment = env
    }
}
