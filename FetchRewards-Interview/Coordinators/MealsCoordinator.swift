//
//  MealsCoordinator.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import UIKit

protocol MealsCoordinator {
    func mealSelected(id: String)
}

class MealsCoordinatorImpl: Coordinator, MealsCoordinator {
    let navigationController: UINavigationController
    let mealRepository: MealRepository
    
    init(navigationController: UINavigationController, mealRepository: MealRepository) {
        self.navigationController = navigationController
        self.mealRepository = mealRepository
    }
    
    func start() {
        
        let mealsVC: MealsViewController = MealsViewController()
        navigationController.pushViewController(mealsVC, animated: false)
    }
    
    func mealSelected(id: String) {
        
    }
}
