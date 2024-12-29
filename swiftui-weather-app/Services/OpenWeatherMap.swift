//
//  OpenWeather.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 19.12.2024.
//

import Foundation
import CoreLocation

struct OpenWeatherMap<T: Decodable> {
    var urlComponent: URLComponents

    func getData() async throws -> Result<T, Error> {
        guard let validUrl = urlComponent.url else {
            throw URLError(.badURL)
        }

        debugPrint(urlComponent.queryItems ?? [])
        var request = URLRequest(url: validUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            debugPrint(response)
            debugPrint(data, response, request, validUrl)
            let weatherData = try JSONDecoder().decode(T.self, from: data)
            
            return .success(weatherData)
        } catch let error {
            debugPrint(error)
           return .failure(error)
        }

    }

}

