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
        let expected1: String = "1. First, do the thing."
        let expected2: String = "2. Then do another thing."
        let expected3: String = "3. Blablabla."
        let actual1: String = viewModel.instructionsText(for: 0)
        let actual2: String = viewModel.instructionsText(for: 1)
        let actual3: String = viewModel.instructionsText(for: 2)

        XCTAssertEqual(actual1, expected1)
        XCTAssertEqual(actual2, expected2)
        XCTAssertEqual(actual3, expected3)
    }

    func testIngredientText() {
        let viewModel: MealDetailsViewModel = MealDetailsViewModelImpl(recipe: recipe)
        let expected1: String = "ABCD NOPQ"
        let expected2: String = "EFGH WXYZ"
        let actual1: String = viewModel.ingredientText(for: 0)
        let actual2: String = viewModel.ingredientText(for: 1)

        XCTAssertEqual(actual1, expected1)
        XCTAssertEqual(actual2, expected2)
    }

}
