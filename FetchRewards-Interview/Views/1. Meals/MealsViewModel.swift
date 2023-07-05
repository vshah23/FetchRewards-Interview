//
//  MealsViewModel.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation
import Combine

enum MealsViewState: CustomStringConvertible {
    case loading
    case loaded
    case noData
    case error(String)

    var description: String {
        switch self {
        case .loading:
            return "loading"
        case .loaded:
            return "loaded"
        case .noData:
            return "noData"
        case .error:
            return "error"
        }
    }
}

@MainActor
protocol MealsViewModel {
    var title: String { get }
    var state: CurrentValueSubject<MealsViewState, Never> { get }

    func fetchMeals() async

    func numberOfMeals() -> Int
    func title(forMealIn row: Int) -> String
    func mealId(forMealIn row: Int) -> String
}

@MainActor
class MealsViewModelImpl: MealsViewModel {
    private let mealsRepository: MealRepository
    var title: String = L10n.Meals.List.title

    var state: CurrentValueSubject<MealsViewState, Never>
    private var meals: [Meal]

    init(mealsRepository: MealRepository) {
        self.mealsRepository = mealsRepository
        self.state = CurrentValueSubject<MealsViewState, Never>(.noData)
        self.meals = []
    }

    func fetchMeals() async {
        state.value = .loading
        do {
            let meals: [Meal] = try await mealsRepository.fetchDesserts()
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

    func title(forMealIn row: Int) -> String {
        return meals[row].strMeal
    }

    func mealId(forMealIn row: Int) -> String {
        return meals[row].idMeal
    }
}
