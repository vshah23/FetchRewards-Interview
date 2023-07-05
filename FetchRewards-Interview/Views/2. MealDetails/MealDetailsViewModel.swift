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

    func instructionsText(for row: Int) -> String
    func ingredientText(for row: Int) -> String
}

class MealDetailsViewModelImpl: MealDetailsViewModel {
    private let recipe: Recipe

    /// Complexity: O(2N) since we make two passes through the string
    /// We can improve this by making a single pass with a sliding window technique
    private lazy var instructions: [String] = {
        var finalInstructions: [String] = []
        guard var instructions: String = recipe.strInstructions else { return [] }
        instructions = instructions.replacingOccurrences(of: "\r\n", with: ". ")
        finalInstructions = instructions.components(separatedBy: ". ")

        for (index, instr) in finalInstructions.enumerated() {
            finalInstructions[index] = instr.trimmingCharacters(in: .punctuationCharacters) + "."
        }

        return finalInstructions
    }()

    private lazy var ingredients: [Ingredient] = recipe.ingredients

    var title: String { recipe.strMeal }

    var numberOfInstructions: Int { instructions.count }

    var numberOfIngredients: Int { ingredients.count }

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    func instructionsText(for row: Int) -> String {
        return "\(row + 1). \(instructions[row])"
    }

    func ingredientText(for row: Int) -> String {
        let ingredient: Ingredient = ingredients[row]
        return "\(ingredient.name) \(ingredient.measure)"
    }
}
