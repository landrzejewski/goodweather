//
//  FoodDetailsView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 01/06/2023.
//

import SwiftUI

struct FoodDetailsView: View {
    
    @Binding
    var isVisible: Bool
    var viewModel: FoodViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 200)
            } placeholder: {
                Image("Placeholder").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 200)
            }
            Text(viewModel.name)
                .font(.title3)
                .fontWeight(.bold)
            Text(viewModel.description)
                .font(.body)
                .lineLimit(1)
            Text(viewModel.price)
                .font(.body)
                .foregroundColor(.mainColor)
            Button { isVisible = false } label: {
                Text("Add to cart")
                    .frame(width: 200, height: 40)
                    .foregroundColor(.white)
                    .background(Color.mainColor)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .border(Color.white, width: 1)
        .clipped()
        .shadow(radius: 10)
        
    }
}

struct FoodDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailsView(isVisible: .constant(true), viewModel: FoodViewModel(id: 1, name: "Asparagus steak", description: "Nice and healthy steak", price: "20 zł", imageUrl: URL(string: "https://github.com/landrzejewski/goodweather/blob/combine/extras/images/asparagus-steak.png?raw=true")!))
    }
}
