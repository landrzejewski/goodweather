//
//  OrderViewModel.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 19/05/2022.
//

import Foundation

final class OrderViewModel: ObservableObject {
    
    @Published
    var orderEntries = [
        OrderEntryViewModel(id: 1, name: "Mega burger", price: "40 zł"),
        OrderEntryViewModel(id: 2, name: "Asparagus steak", price: "20 zł")
    ]
    @Published
    var totalPrice = "60 zł"
    
}
