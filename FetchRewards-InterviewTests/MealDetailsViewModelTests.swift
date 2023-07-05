//
//  MealDetailsViewModelTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/5/23.
//

import XCTest

final class MealDetailsViewModelTests: XCTestCase {
    let recipe: Recipe = Recipe(idMeal: "",
                                strMeal: "",
                                strMealThumb: "",
                                strInstructions:
                                    """
First, do the thing. Then do another thing.\r\nBlablabla
""",
                                strIngredient1: "ABCD",
                                strIngredient2: "",
                                strIngredient13: "EFGH",
                                strMeasure1: "NOPQ",
                                strMeasure2: "RSTU",
                                strMeasure13: "WXYZ")

    func testInstructionsText() {
        let viewModel: MealDetailsViewModel = MealDetailsViewModelImpl(recipe: recipe)
        let expected: String = "First, do the thing. Then do another thing.\r\nBlablabla"
        let actual: String = viewModel.instructionsText()

        XCTAssertEqual(actual, expected)
    }

    func testIngredientText() {
        let viewModel: MealDetailsViewModel = MealDetailsViewModelImpl(recipe: recipe)
        let expected1: String = "Abcd"
        let expected2: String = "Efgh"
        let actual1: String = viewModel.ingredientText(for: 0)
        let actual2: String = viewModel.ingredientText(for: 1)

        XCTAssertEqual(actual1, expected1)
        XCTAssertEqual(actual2, expected2)
    }

    func testIngredientMeasure() {
        let viewModel: MealDetailsViewModel = MealDetailsViewModelImpl(recipe: recipe)
        let expected1: String = "NOPQ"
        let expected2: String = "WXYZ"
        let actual1: String = viewModel.measurementText(for: 0)
        let actual2: String = viewModel.measurementText(for: 1)

        XCTAssertEqual(actual1, expected1)
        XCTAssertEqual(actual2, expected2)
    }

}
