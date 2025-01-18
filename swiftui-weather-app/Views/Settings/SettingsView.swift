//
//  OpenWeatherView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 22.12.2024.
//

import SwiftUI

struct SettingsView<ApiManager: SettingsManager>: View
where ApiManager.V == String {
    var path: any RouterCoordinator<MainRoutes>
    var apiKeyManager: ApiManager

    @Environment(\.openURL) private var openURL
    @State private var apiKey = ""
    @FocusState private var focusField: FocusField?

    var body: some View {
        let apiManagerValue = apiKeyManager.value
        let apiKeyNotSet = apiManagerValue.isEmpty && apiKey.isEmpty

        VStack(spacing: 20) {

            Text(
                """
                Copy your Open weather api key and store it in your phone to be able to access the the weather information.
                Your api key will be used only to fetch data from the open weather api in this phone.
                """
            )
            .font(.headline)
            .multilineTextAlignment(.leading)
            .padding()

            Spacer()

            TextField(
                apiKeyNotSet
                    ? "Type or paste your OpenWeather api key"
                    : (apiManagerValue.isEmpty || apiManagerValue != apiKey
                        ? apiKey : apiManagerValue), text: $apiKey
            ).background(Color.clear).padding([.top, .leading, .trailing])
                .focused($focusField, equals: .textField)

            Button(
                action: {
                    openURL(
                        URL(
                            string:
                                "https://home.openweathermap.org/users/sign_in?student=true"
                        )!)
                },
                label: {
                    Text("Go to Open weather website").fontWeight(.semibold)
                        .foregroundColor(Color.accentColor)
                }
            ).padding()

            Spacer()

            Button(
                action: {
                    apiKeyManager.value = apiKey
                },
                label: {
                    if !apiKeyNotSet {
                        Text("Store your Open Weather Map api key")
                    } else {
                        Text("Create an Open Weather Map api key")
                    }
                }
            ).disabled(apiKeyNotSet).padding()

            Button(
                action: {
                    if apiKeyManager.value != apiKey {
                        if !apiKey.isEmpty {
                            apiKeyManager.value = apiKey
                        }
                    }
                    path.navigate(to: .locationPicker)

                },
                label: {
                    Text("Pick location")
                }
            ).disabled(apiKeyNotSet)
        }.onAppear {
            focusField = .textField

            if apiKey.isEmpty {
                apiKey = apiManagerValue
            }
        }
    }

    private enum FocusField {
        case textField
    }
}
