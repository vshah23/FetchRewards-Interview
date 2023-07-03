//
//  MealDetailsViewModel.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation

protocol MealDetailsViewModel {
    var title: String { get }
}

class MealDetailsViewModelImpl: MealDetailsViewModel {
    private let recipe: Recipe
    
    var title: String { recipe.strMeal }
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
