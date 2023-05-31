//
//  RouterView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI
import Factory

struct RouterView: View {
    
    @Injected(\.forecastViewModel)
    private var forecastViewModel: ForecastViewModel
    @EnvironmentObject
    private var router: Router
    
    var body: some View {
        switch router.route {
        case .forecast:
            ForecastView(viewModel: forecastViewModel)
        }
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
    }
}
