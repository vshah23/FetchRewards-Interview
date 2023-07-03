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

protocol MealsViewModel {
    var title: String { get }
    @MainActor var state: CurrentValueSubject<MealsViewState, Never> { get }

    @MainActor func fetchMeals() async

    func numberOfMeals() -> Int
    func titleForMeal(in row: Int) -> String
    // TODO: func thumbnailForMeal(in row: Int) async -> UIImage
    func mealId(forMealAt row: Int) -> String
}

class MealsViewModelImpl: MealsViewModel {
    private let mealsRepository: MealRepository
    var title: String = "Meals"

    @MainActor var state: CurrentValueSubject<MealsViewState, Never>
    @MainActor private var meals: [Meal]

    init(mealsRepository: MealRepository) {
        self.mealsRepository = mealsRepository
        self.state = CurrentValueSubject<MealsViewState, Never>(.noData)
        self.meals = []
    }

    @MainActor
    func fetchMeals() async {
        state.value = .loading
        do {
            let meals: [Meal] = try await mealsRepository.fetchDesserts()
                .filter { meal in !meal.strMeal.isEmpty }
                .sorted { meal1, meal2 in meal1.strMeal < meal2.strMeal }
            await MainActor.run { [weak self] in
                self?.meals = meals
                self?.state.value = meals.count > 0 ? .loaded : .noData
            }
        } catch {
            self.state.value = .error(ErrorHelper.userFriendlyErrorMessage(for: error))
        }
    }

    @MainActor
    func numberOfMeals() -> Int {
        return meals.count
    }

    @MainActor
    func titleForMeal(in row: Int) -> String {
        return meals[row].strMeal
    }

    @MainActor
    func mealId(forMealAt row: Int) -> String {
        return meals[row].idMeal
    }
}
