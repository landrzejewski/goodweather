//
//  FoodViewModel.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 18/05/2022.
//

import Foundation

struct FoodViewModel: Identifiable {
    
    let id: Int
    let name: String
    let description: String
    let price: String
    let imageUrl: URL

}
