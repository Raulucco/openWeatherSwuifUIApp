//
//  ApiManager.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 22.12.2024.
//

import Foundation


struct ApiManager: Hashable {
    private let API_KEY_NAME = "API_KEY"

    var apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func storeUserApiKey(apiKey: String) {
        UserDefaults.standard.set(API_KEY_NAME, forKey: apiKey)
    }

    func useUserStoredApiKey() -> String? {
        if let apiKeyValue = UserDefaults.standard.string(forKey: API_KEY_NAME) {
            return apiKeyValue
        }
        
        return nil
    }

    func getStoredApiKey() -> String? {
        if let apiKeyValue = ProcessInfo.processInfo.environment[API_KEY_NAME] {
            return apiKeyValue
        } else {
            return useUserStoredApiKey()
        }
    }
}
