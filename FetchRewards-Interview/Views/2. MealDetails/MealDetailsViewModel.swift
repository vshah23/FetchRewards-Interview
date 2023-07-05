//
//  MealDetailsViewModel.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation

protocol MealDetailsViewModel {
    var title: String { get }

    var numberOfInstructions: Int { get }
    var numberOfIngredients: Int { get }

    func instructionsText() -> String
    func ingredientText(for row: Int) -> String
    func measurementText(for row: Int) -> String
}

class MealDetailsViewModelImpl: MealDetailsViewModel {
    private let recipe: Recipe

    private lazy var ingredients: [Ingredient] = recipe.ingredients

    var title: String { recipe.strMeal }

    var numberOfInstructions: Int { 1 }

    var numberOfIngredients: Int { ingredients.count }

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    func instructionsText() -> String {
        return recipe.strInstructions ?? ""
    }

    func ingredientText(for row: Int) -> String {
        return ingredients[row].name.capitalized
    }

    func measurementText(for row: Int) -> String {
        return ingredients[row].measure
    }
}
