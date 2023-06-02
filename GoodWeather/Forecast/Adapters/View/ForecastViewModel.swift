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
    @Published
    var errors = false

    private let forecastService: ForecastService
    private let locationProvider: LocationProvider
    private var subscriptions = Set<AnyCancellable>()
    
    init(forecastService: ForecastService, locationProvider: LocationProvider) {
        self.forecastService = forecastService
        self.locationProvider = locationProvider
        locationProvider.location.sink { [unowned self] location in
            forecastService.getForecast(for: location, callback: onForecastRefreshed)
        }
        .store(in: &subscriptions)
    }
    
    func refreshForecast() {
        if !city.isEmpty {
            refreshForecast(for: city)
        }
    }
    
    func refreshForecast(for city: String) {
        forecastService.getForecast(for: city, callback: onForecastRefreshed)
    }
    
    func refreshForecastForCurrentLocation() {
        locationProvider.refreshLocation()
    }
    
    func onForecastRefreshed(result: Result<Forecast, ForecastProviderError>) {
        onMainThread { [self] in
            switch result {
            case .success(let forecast):
                errors = false
                showForecast(forecast)
            case .failure(_):
                errors = true
            }
        }
    }
    
    func showForecast(_ forecast: Forecast) {
        city = forecast.city
        currentForecast = toViewModel(forecast.weather.first!)
        nextDaysForecast = forecast.weather.dropLast().map(toViewModel)
    }
    
}
