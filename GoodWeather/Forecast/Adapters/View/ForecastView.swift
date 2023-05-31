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
    @AppStorage("city")
    private var city = ""
    @Environment(\.scenePhase)
    private var scenePhase: ScenePhase
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mainColor, .black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image(systemName: "location")
                        .templateStyle(width: 20, height: 20)
                        .onTapGesture { viewModel.refreshForecastForCurrentLocation() }
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
            if viewModel.errors {
                VStack {
                    Spacer()
                    Text("Refresh forecast failed")
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.top, 8)
                        .background(.red)
                }
            }
        }
        .sheet(isPresented: $showSettings) { ForecastSettingsView() }
        .onAppear { viewModel.city = city }
        .onChange(of: city, perform: viewModel.refreshForecast(for:))
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                viewModel.refreshForecast()
            }
        }
    }
    
}

struct ForecastView_Previews: PreviewProvider {
    
    static var previews: some View {
        let forecastService = ForecastService(forecastProvider: FakeForecastProvider(), forecastRepository: FakeForecastRepository())
        ForecastView(viewModel: ForecastViewModel(forecastService: forecastService, locationProvider: FakeLocationProvider()))
    }
}
