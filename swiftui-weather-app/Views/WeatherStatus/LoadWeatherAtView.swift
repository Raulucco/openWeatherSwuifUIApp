//
//  LoadWeatherAtView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 22.12.2024.
//

import CoreLocation
import SwiftUI

struct LoadWeatherAtView: View {
    var path: any RouterCoordinator<MainRoutes>
    let location: CLLocationCoordinate2D
    @EnvironmentObject private var apiManager: ApiManager

    private let currentWeatherData = WeatherDataResponse<CurrentWeatherData>()
    private let forecastData = WeatherDataResponse<WeatherData>()
    private let measurementSystem = Locale.current.measurementSystem
    @State private var currentWeatherDataResponse: CurrentWeatherData?
    @State private var forecastDataResponse: WeatherData?

    var body: some View {

        VStack {

            if let apiKey = apiManager.apiKey {

                if let currentWeatherDataResponse = currentWeatherDataResponse {
                    CurrentWeatherAtView(
                        weatherDataResponse: currentWeatherDataResponse,
                        location: location, apiKey: apiKey)
                } else {
                    ProgressView()
                }

                if let forecastDataResponse = forecastDataResponse {
                    ForecastAtView(
                        weatherDataResponse: forecastDataResponse,
                        location: location, apiKey: apiKey)
                } else {
                    ProgressView()
                }
            } else {
                Text("Please set your Open Weatehr Map API key")
                    .foregroundColor(.red)
            }

        }.task {
            guard
                let currentWeatherUrl = ProcessInfo.processInfo.environment[
                    "CURRENT_FORECAST_API"]
            else {
                print("No current url")
                return
            }

            guard let apiKey = apiManager.apiKey else {
                print("No API key")
                return
            }

            currentWeatherDataResponse = await currentWeatherData.loadForecast(
                url: currentWeatherUrl, location: location, with: apiKey,
                measurementSystem: measurementSystem)

        }.task {
            guard
                let forecastUrl = ProcessInfo.processInfo.environment[
                    "FORECAST_API"]
            else {
                print("no forecast url")
                return
            }

            guard let apiKey = apiManager.apiKey else {
                print("No API key")
                return
            }

            forecastDataResponse = await forecastData.loadForecast(
                url: forecastUrl, location: location, with: apiKey,
                measurementSystem: measurementSystem)
        }

    }
}
