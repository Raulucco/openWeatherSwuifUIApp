//
//  ContentView.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 15.12.2024.
//

import CoreLocation
import SwiftUI

// does the app has an api key to get the weather from
// no: load webview for user to create an api key in open weather and copy it to the app
// strore the app
// load data from api
// load time from os
// use time for appearence
// allow background customisation
struct ContentView: View {

    var body: some View {
        RouterView()
    }

}

#Preview {
    ContentView()
}
