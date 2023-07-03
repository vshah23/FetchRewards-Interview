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
    case error(String)
}

protocol MealsViewModel {
    var title: String { get }
    @MainActor var state: CurrentValueSubject<MealsViewState, Never> { get }

    func fetchMeals() async
    
    func numberOfMeals() -> Int
    func titleForMeal(in row: Int) -> String
    //TODO: func thumbnailForMeal(in row: Int) async -> UIImage
    func mealId(forMealAt row: Int) -> String
}

class MealsViewModelImpl: MealsViewModel {
    private let mealsRepository: MealRepository
    var title: String = "Meals"
    
    @MainActor var state: CurrentValueSubject<MealsViewState, Never> = CurrentValueSubject<MealsViewState, Never>(.loading)
    @MainActor private var meals: [Meal] = []
    

    init(mealsRepository: MealRepository) {
        self.mealsRepository = mealsRepository
    }
    
    func fetchMeals() async {
        do {
            let meals: [Meal] = try await mealsRepository.fetchDesserts()
                .filter { meal in !meal.strMeal.isEmpty }
                .sorted { m1, m2 in m1.strMeal < m2.strMeal }
            await MainActor.run { [weak self] in
                self?.meals = meals
                self?.state.value = .loaded
            }
        } catch {
            await self.state.value = .error(ErrorHelper.userFriendlyErrorMessage(for: error))
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
