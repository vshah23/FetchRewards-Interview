//
//  MealsCoordinator.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import UIKit

class MealsCoordinatorImpl: Coordinator {
    private let navigationController: UINavigationController
    private let mealRepository: MealRepository
    
    init(navigationController: UINavigationController, mealRepository: MealRepository) {
        self.navigationController = navigationController
        self.mealRepository = mealRepository
    }
    
    func start() {
        let mealsVM: MealsViewModel = MealsViewModelImpl(mealsRepository: mealRepository)
        let mealsVC: MealsViewController = MealsViewController(viewModel: mealsVM, delegate: self)
        navigationController.pushViewController(mealsVC, animated: false)
    }
}

extension MealsCoordinatorImpl: MealsViewControllerDelegate {
    @MainActor
    func loadingData() {
        showLoader()
    }
    
    @MainActor
    func finishedLoadingData() {
        hideLoader()
    }
    
    @MainActor
    func errorLoadingData(errorMessage: String) {
        hideLoader()
        showError(errorMessage: errorMessage)
    }
    
    func mealSelected(id: String) {
        
    }
}

extension MealsCoordinatorImpl: LoadingScreenShowable, ErrorShowable {    
    var parentViewController: UIViewController {
        get {
            navigationController
        }
    }
}
