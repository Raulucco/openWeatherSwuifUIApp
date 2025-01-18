//
//  Card.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 15.12.2024.
//

import SwiftUI

struct WeatherStatusView: View {
    var status: Status
    @State var descriptionIsPresented: Bool = false

    var body: some View {
        VStack(alignment: .center) {

            AsyncImage(
                url: URL(
                    string:
                        "https://openweathermap.org/img/wn/\(status.imageName)@2x.png"
                )
            ) {
                image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.frame(width: status.width).onTapGesture {
                descriptionIsPresented = true
            }.alert(status.description, isPresented: $descriptionIsPresented) {
                Button("Dismiss") {
                    descriptionIsPresented = false
                }
            }

            Text(status.dayName).font(
                .system(size: CGFloat(status.dayNameSize), weight: .medium)
            ).foregroundColor(.white)

            Text("\(status.temperature)˚").font(
                .system(size: CGFloat(status.temperatureSize), weight: .medium)
            ).foregroundColor(.white)
        }
    }
}
