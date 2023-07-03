//
//  AppCoordinator.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import UIKit

class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMeals()
    }
    
    private func showMeals() {
        let httpClient: HTTPClient = HTTPClientImpl(session: URLSession.shared)
        let mealRepository: MealRepository = MealRepositoryImpl(httpClient: httpClient)
        let mealsCoordinator: Coordinator = MealsCoordinatorImpl(navigationController: navigationController,
                                                                  mealRepository: mealRepository)
        
        mealsCoordinator.start()
        childCoordinators.append(mealsCoordinator)
    }
}
