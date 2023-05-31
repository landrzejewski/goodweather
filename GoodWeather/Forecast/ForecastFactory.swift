//
//  ForecastFactory.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

final class ForecastFactory {
    
    private lazy var forecastProvider: ForecastProvider = URLSessionForecastProvider()
    
    private lazy var locationProvider: LocationProvider = CoreLocationProvider()
    
    private lazy var forecastRepository: ForecastRepository = FakeForecastRepository()
    
    private lazy var forecastService = ForecastService(forecastProvider: forecastProvider, forecastRepository: forecastRepository)
    
    lazy var forecastViewModel = ForecastViewModel(forecastService: forecastService, locationProvider: locationProvider)
    
}
