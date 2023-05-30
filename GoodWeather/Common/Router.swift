//
//  Router.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import Foundation

final class Router: ObservableObject {
    
    @Published
    var route = Route.forecast
    
}
