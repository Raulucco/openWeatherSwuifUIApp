//
//  ForecastWeatherResponse.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 25.12.2024.
//

import Foundation

struct Coordinates: Decodable {
    let lon: Double
    let lat: Double
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Main
struct Main: Decodable {
    let temp: Double
}

struct WeatherData: Decodable {
    let cod: String
    let city: City?
    let message: Double
    let list: [DailyForecast]
    
    struct DailyForecast: Decodable {

        let main: Main

        let weather: [Weather]

    }
}

struct CurrentWeatherData: Decodable {
    let coord: Coordinates?
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let rain: Rain? // Optional, as rain might not always be present
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String

    // MARK: - Rain
    struct Rain: Decodable {
        let the1H: Double // Renamed to avoid keyword conflict
    }

    // MARK: - Clouds
    struct Clouds: Decodable {
        let all: Int
    }

    // MARK: - Sys
    struct Sys: Decodable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}
