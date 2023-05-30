//
//  ForecastDto.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

struct ForecastDto: Decodable {
    
    let forecast: [DayForecastDto]
    
    enum CodingKeys: String, CodingKey {
        
        case forecast = "list"
        
    }
    
}
