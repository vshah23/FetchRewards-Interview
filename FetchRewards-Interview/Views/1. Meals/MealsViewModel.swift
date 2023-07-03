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
            let menu: Menu = try await mealsRepository.fetchDesserts()
            let meals: [Meal] = menu.meals.sorted { m1, m2 in m1.strMeal < m2.strMeal }
            await MainActor.run { [weak self] in
                self?.meals = meals
                self?.state.value = .loaded
                print(meals)
            }
        } catch {
            //TODO: Handle errors
            await self.state.value = .error(error.localizedDescription)
        }
    }
    
}
