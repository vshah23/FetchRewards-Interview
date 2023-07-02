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
    var state: CurrentValueSubject<MealsViewState, Never> { get }
    var title: String { get }
}

class MealsViewModelImpl: MealsViewModel {
    private let mealsRepository: MealRepository
    
    var state: CurrentValueSubject<MealsViewState, Never> = CurrentValueSubject<MealsViewState, Never>(.loading)
    var title: String = "Meals"

    init(mealsRepository: MealRepository) {
        self.mealsRepository = mealsRepository
    }
}
