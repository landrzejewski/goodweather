//
//  URLSessionForecastProvider.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

final class URLSessionForecastProvider: ForecastProvider {

    private let providerUrl = "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=6&units=metric&APPID=b933866e6489f58987b2898c89f542b8"

    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        getForecast(requestURL: "\(providerUrl)&q=\(city)", callback: callback)
    }
    
    func getForecast(for location: (Double, Double), callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        getForecast(requestURL: "\(providerUrl)&lon=\(location.0)&lat=\(location.1)", callback: callback)
    }
    
    func getForecast(requestURL: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        guard let url = URL(string: requestURL) else {
            callback(.failure(.failed("Invalid request url")))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                callback(.failure(.failed(error.localizedDescription)))
                return
            }
            let responseStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            guard (200...299).contains(responseStatusCode) else {
                callback(.failure(.failed("Request failed with status \(responseStatusCode)")))
                return
            }
            guard let data else {
                callback(.failure(.failed("Invalid response data")))
                return
            }
            do {
                let forecastDto = try JSONDecoder().decode(ForecastDto.self, from: data)
                let forecast = Forecast(city: forecastDto.city.name, weather: forecastDto.forecast.map(toDomain))
                callback(.success(forecast))
            } catch {
                callback(.failure(.failed("Parsing failed")))
            }
        }
        .resume()
    }
    
}
