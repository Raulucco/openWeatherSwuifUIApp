//
//  LoadWeatherAtView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 22.12.2024.
//

import SwiftUI
import CoreLocationUI

struct LoadWeatherAtView: View {
    @StateObject private var userLocation = UserLocation()
    private let currentWeatherData = WeatherDataResponse<CurrentWeatherData>()
    private let forecastData = WeatherDataResponse<WeatherData>()
    private let measurementSystem = Locale.current.measurementSystem
    @State private var currentWeatherDataResponse: CurrentWeatherData?
    @State private var forecastDataResponse: WeatherData?

    var apiKey: String
    var body: some View {
       
        ZStack {
            BackgroundView()
            if let location = userLocation.location {
                VStack {
                    if let currentWeatherDataResponse = currentWeatherDataResponse {
                        CurrentWeatherAtView(weatherDataResponse: currentWeatherDataResponse, location: location, apiKey: apiKey)
                    } else {
                        ProgressView()
                    }
                
                    if let forecastDataResponse = forecastDataResponse {
                        ForecastAtView(weatherDataResponse: forecastDataResponse, location: location, apiKey: apiKey)
                    } else {
                        ProgressView()
                    }
                }.task {
                    guard let currentWeatherUrl = ProcessInfo.processInfo.environment["CURRENT_FORECAST_API"] else {
                        print("No current url")
                        return
                    }
                    
                    currentWeatherDataResponse = await currentWeatherData.loadForecast(url: currentWeatherUrl, location: location, with: apiKey, measurementSystem: measurementSystem)
                    
                }.task {
                    guard let forecastUrl = ProcessInfo.processInfo.environment["FORECAST_API"] else {
                        print("no forecast url")
                        return
                    }
                    
                    forecastDataResponse = await forecastData.loadForecast(url: forecastUrl, location: location, with: apiKey, measurementSystem: measurementSystem)
                }

            } else {
                LocationButton {
                    userLocation.requestLocation()
                }
            }
        }

    }
}
//
//#Preview {
//    LoadWeatherAtView(apiKey: "")
//}
