//
//  URLSessionForecastProvider.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

final class URLSessionForecastProvider: ForecastProvider {
    
    private let url = "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=6&units=metric&APPID=b933866e6489f58987b2898c89f542b8&q="
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        guard let requestURL = URL(string: "\(url)\(city)") else {
            callback(.failure(.failed("Invalid request url")))
            return
        }
        let request = URLRequest(url: requestURL)
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
                let forecast = Forecast(city: city, weather: forecastDto.forecast.map(self.toDomain))
                callback(.success(forecast))
            } catch {
                callback(.failure(.failed("Parsing failed")))
            }
        }
        .resume()
    }
    
    private func toDomain(dayForecastDto: DayForecastDto) -> DayForecast {
        let date = Date(timeIntervalSince1970: dayForecastDto.date)
        let icon = dayForecastDto.weather.first?.icon ?? ""
        let description = dayForecastDto.weather.first?.description ?? ""
        let temperature = dayForecastDto.temperature.day
        let pressure = dayForecastDto.pressure
        return DayForecast(date: date, icon: icon, description: description, temperature: temperature, pressure: pressure)
    }
    
}
