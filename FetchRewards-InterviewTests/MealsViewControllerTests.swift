//
//  MealsViewControllerTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/4/23.
//

import Combine
import XCTest

final class MealsViewControllerTests: XCTestCase {

    func testCellTypes() {
        let expectedCellTypes: [UITableViewCell.Type] = [UITableViewCell.self]
        let actualCellTypes: [UITableViewCell.Type] = MealsViewController.cellTypes
        for (actualCellType, expectedCellType) in zip(actualCellTypes, expectedCellTypes) {
            XCTAssertTrue(actualCellType == expectedCellType)
        }
    }

    func testViewDidLoad() {
        struct StubViewModel: MealsViewModel {
            var title: String { "Screen" }

            var state: CurrentValueSubject<MealsViewState, Never> = CurrentValueSubject<MealsViewState, Never>(.noData)

            func fetchMeals() async { }

            func numberOfMeals() -> Int { 0 }

            func titleForMeal(in row: Int) -> String { "" }

            func mealId(forMealAt row: Int) -> String { "" }
        }

        let viewModel: StubViewModel =  StubViewModel()
        let viewController: MealsViewController = MealsViewController(viewModel: viewModel)

        let expectedTitle: String = "Screen"

        _ = viewController.view
        let tableView: UITableView = viewController.tableView

        let actualTitle: String? = viewController.title

        let registeredCellClasses: [String: Any]? = tableView.value(forKey: "_cellClassDict") as? [String: Any]

        XCTAssertTrue(registeredCellClasses?.contains { $1 as? UITableViewCell.Type == UITableViewCell.self } ?? false)
        XCTAssertNotNil(tableView.refreshControl)
        let refreshControl: UIRefreshControl = tableView.refreshControl!

        XCTAssertTrue(refreshControl.allTargets.contains(viewController))
        let expectedRefreshControlTitle: NSAttributedString = NSAttributedString(string: "Fetching recipes...",
                                                                                 attributes: nil)
        XCTAssertEqual(refreshControl.attributedTitle, expectedRefreshControlTitle)

        XCTAssertEqual(actualTitle, expectedTitle)
    }

}
