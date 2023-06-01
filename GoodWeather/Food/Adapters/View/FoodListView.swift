//
//  FoodListView.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 01/06/2023.
//

import SwiftUI
import Factory

struct FoodListView: View {
    
    @ObservedObject
    var viewModel: FoodListViewModel

    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.food) { food in
                    FoodView(viewModel: food)
                        .onTapGesture {
                            viewModel.showDetails = true
                            viewModel.selectedFood = food
                        }
                }
                .disabled(viewModel.showDetails)
                .blur(radius: viewModel.showDetails ? 5 : 0.0)
                if !viewModel.isLoading && viewModel.food.isEmpty {
                    PlaceholderView(imageName: "info.bubble", message: "Menu is unavailable")
                }
                if viewModel.isLoading {
                    LoadingView()
                }
                if let selectedFood = viewModel.selectedFood, viewModel.showDetails {
                    FoodDetailsView(isVisible: $viewModel.showDetails, viewModel: selectedFood)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {}) {
                        Image(systemName: "cart")
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(viewModel: Container.shared.foodListViewModel())
    }
}
