//
//  ForecastService.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation

final class ForecastService {
    
    private let forecastProvider: ForecastProvider
    private let forecastRepository: ForecastRepository
    
    init(forecastProvider: ForecastProvider, forecastRepository: ForecastRepository) {
        self.forecastProvider = forecastProvider
        self.forecastRepository = forecastRepository
    }
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        forecastProvider.getForecast(for: city, callback: callback)
    }
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        forecastProvider.getForecast(for: location, callback: callback)
    }
    
}
