//
//  ForecastFactory.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

final class ForecastFactory {
    
    private lazy var forecastProvider: ForecastProvider = URLSessionForecastProvider()
    
    lazy var forecastViewModel = ForecastViewModel(forecastProvider: forecastProvider)
    
}
