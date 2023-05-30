//
//  ForecastView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

struct ForecastView: View {
    
    @ObservedObject
    var viewModel: ForecastViewModel
    @State
    private var showSettings = false
    @EnvironmentObject
    private var router: Router
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mainColor, .black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image(systemName: "location")
                        .templateStyle(width: 20, height: 20)
                    Spacer()
                    Image(systemName: "slider.horizontal.3")
                        .templateStyle(width: 20, height: 20)
                        .onTapGesture { showSettings = true }
                }
                .padding()
                Text(viewModel.city)
                    .defaultStyle(size: 32)
                    .onTapGesture { router.route = .forecastDtails }
                Spacer()
                if let currentForecast = viewModel.currentForecast {
                    Image(systemName: currentForecast.icon)
                        .iconStyle(width: 200, height: 200)
                    Text(currentForecast.description)
                        .defaultStyle(size: 32)
                    HStack(spacing: 32.0) {
                        Text(currentForecast.temperature)
                            .defaultStyle(size: 16)
                        Text(currentForecast.pressure)
                            .defaultStyle(size: 16)
                    }
                }
                Spacer()
                HStack {
                    ForEach(viewModel.nextDaysForecast, id: \.date) {
                        DayForecastView(viewModel: $0)
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) { ForecastSettingsView() }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: ForecastViewModel(forecastProvider: FakeForecastProvider()))
    }
}
