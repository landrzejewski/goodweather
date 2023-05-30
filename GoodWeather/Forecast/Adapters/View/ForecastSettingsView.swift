//
//  ForecastSettingsView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

struct ForecastSettingsView: View {
    
    @State
    private var city = ""
    @Environment(\.presentationMode)
    private var mode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { mode.wrappedValue.dismiss() }) { closeButton }
            }
            .padding(.top, 6)
            Form {
                Section(header: Text("Place")) {
                    TextField("Enter city name:", text: $city)
                }
            }
        }
    }
    
    private var closeButton: some View {
        Image(systemName: "xmark.circle")
            .templateStyle(width: 20, height: 20, color: .gray)
            .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 6))
    }
}

struct ForecastSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastSettingsView()
    }
}
