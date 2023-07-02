//
//  MealsViewModel.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation
import Combine

enum MealsViewState: Equatable {
    case loading
    case loaded
    case error(String)
}

class MealsViewModel {
    private let mealsRepository: MealRepository
    
    let state: CurrentValueSubject<MealsViewState, Never> = CurrentValueSubject<MealsViewState, Never>(.loading)
    let title: String = "Meals"

    init(mealsRepository: MealRepository) {
        self.mealsRepository = mealsRepository
    }
}
