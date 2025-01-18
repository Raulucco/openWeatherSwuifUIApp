//
//  Card.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 15.12.2024.
//

import SwiftUI

struct WeatherStatusView: View {
    var temperature: String
    var imageName: String
    var dayName: String
    var dayNameSize = 16
    var temperatureSize = 20
    let width: CGFloat
    
    var body: some View {
        VStack(alignment: .center) {
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(imageName)@2x.png")) {
                image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.frame(width: width)
            
            Text(dayName).font(.system(size: CGFloat(dayNameSize), weight: .medium)).foregroundColor(.white)
                
            Text("\(temperature)˚").font(.system(size: CGFloat(temperatureSize), weight: .medium)).foregroundColor(.white)
        }
    }
}
