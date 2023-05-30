//
//  RouterView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

struct RouterView: View {
    
    private let factory = ApplicationFactory.shared
    @EnvironmentObject
    private var router: Router
    
    var body: some View {
        switch router.route {
        case .forecast:
            ForecastView(viewModel: factory.forecast.forecastViewModel)
        default:
            Text("Not found")
        }
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
    }
}
