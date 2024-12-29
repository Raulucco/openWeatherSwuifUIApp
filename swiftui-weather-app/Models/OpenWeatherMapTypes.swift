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

//struct Temperature: Decodable {
//    let day: Double
//    let min: Double
//    let max: Double
//    let night: Double
//    let eve: Double
//    let morn: Double
//}

//struct FeelsLike: Decodable {
//    let day: Double
//    let night: Double
//    let eve: Double
//    let morn: Double
//}


struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Main
struct Main: Decodable {
    let temp: Double
//        let feelsLike: Double
//        let tempMin: Double
//        let tempMax: Double
//        let pressure: Int
//        let humidity: Int
//        let seaLevel: Int
//        let grndLevel: Int
}

struct WeatherData: Decodable {
    let cod: String
    let city: City?
    let message: Double
    let list: [DailyForecast]
    
    struct DailyForecast: Decodable {
        //let dt: TimeInterval // Unix timestamp (seconds since 1970-01-01 00:00:00 UTC)
    //    let sunrise: TimeInterval
    //    let sunset: TimeInterval
        let main: Main
//        let feelsLike: FeelsLike
//        let pressure: Int
//        let humidity: Int
        let weather: [Weather]
//        let speed: Double
//        let deg: Int
//        let clouds: Int
//        let rain: Double? // Optional, as rain might not always be present
    }
}

struct CurrentWeatherData: Decodable {
    let coord: Coordinates?
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
//    let wind: Wind
    let rain: Rain? // Optional, as rain might not always be present
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
//    let cod: Int



    // MARK: - Wind
//    struct Wind: Decodable {
//        let speed: Double
//        let deg: Int
////        let gust: Double
//    }

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
