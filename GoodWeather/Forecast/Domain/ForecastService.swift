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
        try? forecastRepository.get(by: city) { result in
            if case let .success(forecast) = result {
                callback(.success(forecast))
            }
        }
        forecastProvider.getForecast(for: city) { [unowned self] result in
            switch result {
            case .success(let forecast):
                try? forecastRepository.deleteAll()
                try? forecastRepository.save(forecast: forecast)
                callback(result)
            case .failure(_):
                callback(result)
            }
        }
    }
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        forecastProvider.getForecast(for: location, callback: callback)
    }
    
}
