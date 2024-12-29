//
//  OpenWeatherView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 22.12.2024.
//

import SwiftUI

struct OpenWeatherMapView: View {
    @Binding var apiManager: ApiManager
    @State private var showEmptyApiKeyAlert = false
    @Environment(\.openURL) var openURL
    
    @Binding var path: NavigationPath

    var body: some View {

        ZStack {
            BackgroundView()
            
            VStack {
                Text("Copy your Open weather api key and store it in your phone to be able to access the the weather information. Your api key will be used only to fetch data from the open weather api in this phone.")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                       .lineLimit(nil).padding()
                
                Button(action: {
                    openURL(URL(string: "https://home.openweathermap.org/users/sign_in?student=true")!)
                }, label: {
                    Text("Go to Open weather website").fontWeight(.semibold).foregroundColor(Color.white)
                })
                TextField("Type or paste your OpenWeather api key", text: $apiManager.apiKey).background(Color.white).padding([.top, .leading, .trailing])
                
                Spacer()
                
                Button(action: {
                    if !apiManager.apiKey.isEmpty {
                        apiManager.storeUserApiKey(apiKey: apiManager.apiKey)
                    } else {
                        showEmptyApiKeyAlert = true
                    }
                    
                }, label: {
                    if !apiManager.apiKey.isEmpty {
                        Text("Store your Open Weather Map api key")
                    } else {
                        Text("Create an Open Weather Map api key")
                    }
                 
                }).alert(Text("The api key field below is empty"), isPresented: $showEmptyApiKeyAlert) {
                    Button("OK", role: .cancel) {
                        showEmptyApiKeyAlert = false
                    }
                }
            
                Button("Use api key") {
                    DispatchQueue.main.async {
                        path.append(apiManager.apiKey)
                    }
                }
                

            }.onAppear {
                guard let apiKey = apiManager.getStoredApiKey() else {
                    print("No API KEY")
                    return
                }
                
                apiManager.apiKey = apiKey
            }
        }
    }
}

