//
//  MealsViewControllerTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/4/23.
//

import Combine
import XCTest

final class MealsViewControllerTests: XCTestCase {

    struct StubViewModel: MealsViewModel {
        var title: String { "Screen" }

        var state: CurrentValueSubject<MealsViewState, Never> = CurrentValueSubject<MealsViewState, Never>(.noData)

        func fetchMeals() async { }

        func numberOfMeals() -> Int { 25 }

        func titleForMeal(in row: Int) -> String { "Pound Cake" }

        func mealId(forMealAt row: Int) -> String { "DEADBEEF" }
    }

    class StubMealsViewControllerDelegate: MealsViewControllerDelegate {
        var receivedMealId: String = ""

        func loadingData() { }

        func finishedLoadingData() { }

        func errorLoadingData(errorMessage: String) { }

        func mealSelected(id: String) {
            receivedMealId = id
        }
    }

    var viewModel: StubViewModel!
    var viewController: MealsViewController!

    override func setUp() {
        viewModel = StubViewModel()
        viewController = MealsViewController(viewModel: viewModel)
    }

    func testViewDidLoad() {
        let expectedTitle: String = "Screen"
        let expectedRefreshControlTitle: NSAttributedString = NSAttributedString(string: "Fetching recipes...",
                                                                                 attributes: nil)

        _ = viewController.view
        let actualTitle: String? = viewController.title
        let tableView: UITableView = viewController.tableView
        let refreshControl: UIRefreshControl? = tableView.refreshControl
        let registeredCellClasses: [String: Any]? = tableView.value(forKey: "_cellClassDict") as? [String: Any]

        XCTAssertTrue(registeredCellClasses?.contains { $1 as? UITableViewCell.Type == UITableViewCell.self } ?? false)
        XCTAssertNotNil(refreshControl)
        XCTAssertTrue(refreshControl?.allTargets.contains(viewController!) ?? false)
        XCTAssertEqual(refreshControl?.attributedTitle, expectedRefreshControlTitle)

        XCTAssertEqual(actualTitle, expectedTitle)
    }

    func testNumberOfSections() {
        let expectedNumberOfSections: Int = 1
        let actualNumberOfSections: Int = viewController.numberOfSections(in: viewController.tableView)

        XCTAssertEqual(actualNumberOfSections, expectedNumberOfSections)
    }

    func testNumberOfRowsInSection() {
        let expectedNumberOfRows: Int = 25
        let actualNumberOfRows: Int = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)

        XCTAssertEqual(actualNumberOfRows, expectedNumberOfRows)
    }

    func testCellForRowAt() {
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        let cell: UITableViewCell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)
        let expectedTitleForRow: String = "Pound Cake"
        let actualTitleForRow: String? = cell.textLabel?.text

        XCTAssertEqual(actualTitleForRow, expectedTitleForRow)
    }

    func testDidSelectRowAt() {
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        let delegate: StubMealsViewControllerDelegate = StubMealsViewControllerDelegate()
        viewController = MealsViewController(viewModel: viewModel, delegate: delegate)
        viewController.tableView(viewController.tableView, didSelectRowAt: indexPath)

        let expectedMealId: String = "DEADBEEF"
        let actualMealId: String = delegate.receivedMealId

        XCTAssertEqual(actualMealId, expectedMealId)
    }

    func testCellTypes() {
        let expectedCellTypes: [UITableViewCell.Type] = [UITableViewCell.self]
        let actualCellTypes: [UITableViewCell.Type] = MealsViewController.cellTypes

        for (actualCellType, expectedCellType) in zip(actualCellTypes, expectedCellTypes) {
            XCTAssertTrue(actualCellType == expectedCellType)
        }
    }

}
