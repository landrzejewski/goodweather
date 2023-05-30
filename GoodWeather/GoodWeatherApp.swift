//
//  GoodWeatherApp.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

@main
struct GoodWeatherApp: App {
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(Router())
        }
    }
    
}
