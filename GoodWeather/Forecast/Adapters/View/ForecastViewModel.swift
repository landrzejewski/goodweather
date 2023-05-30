//
//  ForecastViewModel.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation
import Combine

final class ForecastViewModel: ObservableObject {
    
    @Published
    var city = ""
    @Published
    var currentForecast: DayForecastViewModel?
    @Published
    var nextDaysForecast: [DayForecastViewModel] = []
    
    init(forecastProvider: ForecastProvider) {
        forecastProvider.getForecast(for: "warsaw") { [self] result in
            switch result {
            case .success(let forecast):
                showForecast(forecast)
            default:
                print("failed")
            }
            
        }
    }
    
    func showForecast(_ forecast: Forecast) {
        DispatchQueue.main.async { [self] in
            city = "Warsaw"
            currentForecast = toViewModel(forecast.weather.first!)
            nextDaysForecast = forecast.weather.dropLast()
                .map(toViewModel)
        }
    }
    
    private func toViewModel(_ dayForecast: DayForecast) -> DayForecastViewModel {
        let date = formatDate(dayForecast.date)
        let icon = mapIcon(dayForecast.icon)
        let temperature = formatTemperature(dayForecast.temperature)
        let pressure = formatPressure(dayForecast.pressure)
        return DayForecastViewModel(date: date, icon: icon, description: dayForecast.description, temperature: temperature , pressure: pressure)
    }
    
}
