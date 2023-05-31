//
//  ForecastDetails.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import SwiftUI
import Factory

struct ForecastDetails: View {
    
    @ObservedObject
    var viewModel: ForecastViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ForecastDetails_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: Container.shared.forecastViewModel())
    }
}
