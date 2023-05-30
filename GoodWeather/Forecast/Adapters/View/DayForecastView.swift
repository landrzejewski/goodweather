//
//  DayForecastView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

struct DayForecastView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("Pn")
                .defaultStyle()
            Image(systemName: "sun.max.fill")
                .iconStyle()
            Text("18°")
                .defaultStyle()
        }
    }
}

struct DayForecastView_Previews: PreviewProvider {
    static var previews: some View {
        DayForecastView()
    }
}
