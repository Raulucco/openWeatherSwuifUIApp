//
//  WeatherAtView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 21.12.2024.
//

import CoreLocation
import SwiftUI

struct ForecastAtView: View {
    var weatherDataResponse: WeatherData
    var location: CLLocationCoordinate2D
    var apiKey: String

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width / 5 // hardcoded number because is fixed number of days

            ScrollView(.horizontal) {
                let nextWeekDays = getNextDays(
                    totalDays: weatherDataResponse.list.count)

                LazyHStack(alignment: .center, spacing: 20) {
                    ForEach(Array(nextWeekDays.enumerated()), id: \.element) {
                        index, weekDay in
                        let day = weatherDataResponse.list[index]

                        let temperature = String(format: "%.1f", day.main.temp)

                        WeatherStatusView(
                            status: Status(
                                temperature: temperature,
                                imageName: day.weather.first?.icon
                                    ?? "exclamationmark.triangle.fill",
                                dayName: weekDay.weekDay,
                                description: day.weather.first?.description
                                    ?? "Missing weather  description",
                                width: width)
                        ).padding(16).frame(width: width)
                    }
                }

            }
        }

    }

}

#Preview {
    let weatherDataResponse = WeatherData(
        cod: "200",
        city: City(
            id: 1, name: "Praha", coord: Coordinates(lon: 0, lat: 0),
            country: ""), message: 0,
        list: [
            WeatherData.DailyForecast(
                main: Main(temp: 13),
                weather: [Weather(id: 2, main: "", description: "", icon: "1d")]
            )
        ])
    ForecastAtView(
        weatherDataResponse: weatherDataResponse,
        location: CLLocationCoordinate2D(
            latitude: CLLocationDegrees(), longitude: CLLocationDegrees()),
        apiKey: "")
}
