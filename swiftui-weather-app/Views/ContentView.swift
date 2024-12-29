//
//  ContentView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 15.12.2024.
//

import CoreLocation
import SwiftUI
// does the app has an api key to get the weather from
    // no: load webview for user to create an api key in open weather and copy it to the app
    // strore the app
// load data from api
// load time from os
// use time for appearence
// allow background customisation
struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var apiManager = ApiManager(apiKey: "")

    var body: some View {
        
        ZStack {
            BackgroundView()

            NavigationStack(path: $path) {
                OpenWeatherMapView(apiManager: $apiManager, path: $path).navigationDestination(for: String.self) { apiKey in
                    LoadWeatherAtView(apiKey: apiKey)
                }
            }.navigationTitle(Text("My Open Weather Map")).onAppear {
                guard let apiKey = apiManager.getStoredApiKey() else {
                    return
                }
                                
                apiManager.apiKey = apiKey
                path.append(apiKey)

            }
            
        }
            
        Spacer()
    }
    
}

#Preview {
    ContentView()
}



