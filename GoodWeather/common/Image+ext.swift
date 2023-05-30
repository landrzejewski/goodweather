//
//  Image+ext.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

extension Image {
    
    func iconStyle(width: CGFloat = 40, height: CGFloat = 40) -> some View {
        renderingMode(.original)
            .size(width: width, height: height)
    }
    
    func templateStyle(width: CGFloat = 40, height: CGFloat = 40, color: Color = .white) -> some View {
        renderingMode(.template)
            .size(width: width, height: height)
            .foregroundColor(color)
    }
    
    private func size(width: CGFloat, height: CGFloat) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: width)
    }
    
}
