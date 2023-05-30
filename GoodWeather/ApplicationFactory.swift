//
//  ApplicationFactory.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

final class ApplicationFactory {
    
    static let shared = ApplicationFactory()
    
    var forecast = ForecastFactory();
    
    private init() {
    }
    
}
