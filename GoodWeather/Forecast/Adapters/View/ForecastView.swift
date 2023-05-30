//
//  ForecastView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

struct ForecastView: View {
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
                        .onTapGesture {
                            print("tap")
                        }
                }
                .padding()
                Text("Poznań")
                    .defaultStyle(size: 32)
                Spacer()
                Image(systemName: "sun.max.fill")
                    .iconStyle(width: 200, height: 200)
                Text("Clear sky")
                    .defaultStyle(size: 32)
                HStack(spacing: 32.0) {
                    Text("12°")
                        .defaultStyle(size: 16)
                    Text("1000hPa")
                        .defaultStyle(size: 16)
                }
                Spacer()
                HStack {
                    DayForecastView()
                    DayForecastView()
                    DayForecastView()
                    DayForecastView()
                    DayForecastView()
                    DayForecastView()
                }
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
