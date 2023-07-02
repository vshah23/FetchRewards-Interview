//
//  MealsCoordinator.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import UIKit

class MealsCoordinatorImpl: Coordinator {
    let navigationController: UINavigationController
    let mealRepository: MealRepository
    
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
    func loadingData() {
        showLoader()
    }
    
    func finishedLoadingData() {
        hideLoader()
    }
    
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
