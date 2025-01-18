//
//  TitleCard.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 15.12.2024.
//
import SwiftUI

struct CurrentWeatherStatusView: View {
    var title: String = ""
    var temperature: String
    var imageName: String
    var dayName: String
    var description: String
    let width: CGFloat

    var body: some View {
        Text(title).font(.largeTitle).fontWeight(.heavy).foregroundColor(
            Color.white)

        /*
         temperature: status.temperature, imageName: status.imageName, dayName: dayName,
         description: description, dayNameSize: 32, temperatureSize: 48,
         width: width
         */
        WeatherStatusView(status: Status(temperature: temperature, imageName: imageName, dayName: dayName, description: description, dayNameSize: 32, temperatureSize: 48, width: width)
            )
    }
}
