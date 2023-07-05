//
//  MealsCoordinator.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import UIKit

class MealsCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let mealRepository: MealRepository

    init(navigationController: UINavigationController, mealRepository: MealRepository) {
        self.navigationController = navigationController
        self.mealRepository = mealRepository
    }
}

@MainActor
extension MealsCoordinator {
    func start() {
        showMeals()
    }

    private func showMeals() {
        let mealsVM: MealsViewModel = MealsViewModelImpl(mealsRepository: mealRepository)
        let mealsVC: MealsViewController = MealsViewController(viewModel: mealsVM, delegate: self)
        navigationController.pushViewController(mealsVC, animated: false)
    }

    private func showMealDetails(for recipe: Recipe) {
        let viewModel: MealDetailsViewModel = MealDetailsViewModelImpl(recipe: recipe)
        let viewController: MealDetailsViewController = MealDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MealsCoordinator: MealsViewControllerDelegate {
    @MainActor
    func loadingData() {
        showLoader()
    }

    @MainActor
    func finishedLoadingData() {
        Task { [weak self] in await self?.hideLoader() }
    }

    @MainActor
    func errorLoadingData(errorMessage: String) {
        Task { [weak self] in
            await self?.hideLoader { [weak self] in
                await self?.showError(errorMessage: errorMessage)
            }
        }
    }

    @MainActor
    func mealSelected(id: String) {
        showLoader()
        Task { [weak self] in await self?.mealSelected(id: id) }
    }

    private func mealSelected(id: String) async {
        do {
            let recipe: Recipe = try await mealRepository.fetchDessert(id: id)
            await hideLoader { [weak self] in
                await self?.showMealDetails(for: recipe)
            }
        } catch {
            await hideLoader { [weak self] in
                await self?.showError(errorMessage: ErrorHelper.userFriendlyErrorMessage(for: error))
            }
        }
    }
}

extension MealsCoordinator: LoadingScreenShowable, ErrorShowable {
    var viewControllerForDisplay: UIViewController { navigationController }
}
