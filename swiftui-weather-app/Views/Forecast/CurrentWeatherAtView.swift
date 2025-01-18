//
//  CurrentWeatherAtView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 25.12.2024.
//

import CoreLocation
import SwiftUI

struct CurrentWeatherAtView: View {
    var weatherDataResponse: CurrentWeatherData
    var location: CLLocationCoordinate2D
    var apiKey: String
    private let today = getToday()

    var body: some View {
        GeometryReader { geo in
            VStack {

                CurrentWeatherStatusView(
                    title: today.day,
                    temperature: String(
                        format: "%.1f", weatherDataResponse.main.temp),
                    imageName: weatherDataResponse.weather.first!.icon,
                    dayName: today.weekDay,
                    description: weatherDataResponse.base.description,
                    width: geo.size.width)

            }.frame(width: geo.size.width)
        }
    }

}
