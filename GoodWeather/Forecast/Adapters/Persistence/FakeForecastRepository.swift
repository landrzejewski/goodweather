//
//  FakeForecastRepository.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation

final class FakeForecastRepository: ForecastRepository {
    
    private var data: [String: Forecast] = [:]
    
    func save(forecast: Forecast) {
        data[forecast.city] = forecast
    }
    
    func deleteAll() {
        data.removeAll()
    }
    
    func get(by city: String, callback: @escaping (Result<Forecast, ForecastRepositoryError>) -> ()) {
        callback(.success(data[city]!))
    }
    
}
