//
//  MealsViewModel.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation
import Combine

enum MealsViewState {
    case loading
    case loaded
    case noData
    case error(String)
}

@MainActor
protocol MealsViewModel {
    var title: String { get }
    var state: CurrentValueSubject<MealsViewState, Never> { get }

    func fetchMeals() async

    func numberOfMeals() -> Int
    func titleForMeal(in row: Int) -> String
    func mealId(forMealAt row: Int) -> String
}

@MainActor
class MealsViewModelImpl: MealsViewModel {
    private let mealsRepository: MealRepository
    var title: String = "Meals"

    var state: CurrentValueSubject<MealsViewState, Never>
    private var meals: [Recipe]

    init(mealsRepository: MealRepository) {
        self.mealsRepository = mealsRepository
        self.state = CurrentValueSubject<MealsViewState, Never>(.noData)
        self.meals = []
    }

    func fetchMeals() async {
        state.value = .loading
        do {
            let meals: [Recipe] = try await mealsRepository.fetchDesserts()
                .filter { meal in !meal.strMeal.isEmpty }
                .sorted { meal1, meal2 in meal1.strMeal < meal2.strMeal }
            self.meals = meals
            state.value = meals.count > 0 ? .loaded : .noData
        } catch {
            state.value = .error(ErrorHelper.userFriendlyErrorMessage(for: error))
        }
    }

    func numberOfMeals() -> Int {
        return meals.count
    }

    func titleForMeal(in row: Int) -> String {
        return meals[row].strMeal
    }

    func mealId(forMealAt row: Int) -> String {
        return meals[row].idMeal
    }
}
