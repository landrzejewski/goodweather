//
//  FakeForecastProvider.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 29/05/2023.
//

import Foundation

final class FakeForecastProvider: ForecastProvider {
    
    private let weather = [
        DayForecast(date: Date(), icon: "02d", description: "Clear sky", temperature: 20.0, pressure: 1_000.0),
        DayForecast(date: Date(), icon: "01d", description: "Clear sky", temperature: 18.0, pressure: 1_001.0),
        DayForecast(date: Date(), icon: "03d", description: "Rain", temperature: 15.0, pressure: 999.0)
    ]
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        let forecast = Forecast(city: city, weather: weather)
        callback(.success(forecast))
    }
    
}
