//
//  ForecastProvider.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 29/05/2023.
//

import Foundation

protocol ForecastProvider {
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ())
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ())
    
}
