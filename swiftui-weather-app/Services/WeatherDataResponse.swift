//
//  WeatherDataResponse.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 22.12.2024.
//

import CoreLocation
import Foundation

class WeatherDataResponse<T: Decodable>: ObservableObject {
    private func addQueryItems(
        urlComponents: inout URLComponents, newQueryItems: [URLQueryItem]
    ) {
        guard urlComponents.queryItems != nil else {
            urlComponents.queryItems = newQueryItems
            return
        }

        urlComponents.queryItems?.append(contentsOf: newQueryItems)
    }

    func addLocationTo(
        urlComponents: inout URLComponents, location: CLLocationCoordinate2D
    ) {
        addQueryItems(
            urlComponents: &urlComponents,
            newQueryItems: [
                URLQueryItem(name: "lat", value: location.latitude.formatted()),
                URLQueryItem(
                    name: "lon", value: location.longitude.formatted()),
            ])
    }

    func addMeasurementsTo(
        urlComponents: inout URLComponents,
        measurementSystem: Locale.MeasurementSystem
    ) {
        let units = measurementSystem == .metric ? "metric" : "imperial"

        addQueryItems(
            urlComponents: &urlComponents,
            newQueryItems: [URLQueryItem(name: "units", value: units)])
    }

    func addApiKeyTo(urlComponents: inout URLComponents, apiKey: String) {
        addQueryItems(
            urlComponents: &urlComponents,
            newQueryItems: [URLQueryItem(name: "appid", value: apiKey)])
    }

    func addCntTo(urlComponents: inout URLComponents, cnt: Int) throws {
        let maxDays = 5
        let minDays = 1

        if cnt > maxDays || cnt < minDays {
            fatalError(
                "Invalid cnt argument value. Cnt must be between \(minDays) and \(maxDays). Cnt was \(cnt) instead"
            )
        }
        addQueryItems(
            urlComponents: &urlComponents,
            newQueryItems: [URLQueryItem(name: "cnt", value: cnt.formatted())])
    }

    func loadForecast(
        url: String, location: CLLocationCoordinate2D, with apiKey: String,
        measurementSystem: Locale.MeasurementSystem
    ) async -> T? {
        guard var urlComponent = URLComponents(string: url) else {
            print("Invlid url \(url)")
            return nil
        }

        addApiKeyTo(urlComponents: &urlComponent, apiKey: apiKey)
        addLocationTo(urlComponents: &urlComponent, location: location)
        addMeasurementsTo(
            urlComponents: &urlComponent, measurementSystem: measurementSystem)
        let openWeather = OpenWeatherMap<T>(urlComponent: urlComponent)

        let result = try? await openWeather.getData()

        switch result {
        case .success(let weaderData):
            print(weaderData)
            return weaderData
        case .failure(let error):
            fatalError(error.localizedDescription)
        case .none:
            return nil
        }
    }
}
