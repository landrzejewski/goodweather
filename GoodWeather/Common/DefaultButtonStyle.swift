//
//  DefaultButtonStyle.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 31/05/2023.
//

import Foundation
import SwiftUI

struct DefaultButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.mainColor.opacity(0.5) : Color.gray)
    }
    
}
