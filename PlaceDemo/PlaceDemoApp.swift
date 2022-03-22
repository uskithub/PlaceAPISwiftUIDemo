//
//  PlaceDemoApp.swift
//  PlaceDemo
//
//  Created by 斉藤 祐輔 on 2022/03/16.
//

import SwiftUI
//import GoogleMaps
import GooglePlaces

@main
struct PlaceDemoApp: App {
    let apiKey = ""
    
    init() {
//        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView2()
        }
    }
}
