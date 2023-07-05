//
//  MealsViewModelImplTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/5/23.
//

import XCTest
import Combine

final class MealsViewModelImplTests: XCTestCase {
    struct StubHTTPClientSession: HTTPClientSession {
        func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
            return (Data(), URLResponse())
        }
    }

    struct StubHTTPClient: HTTPClient {
        init(session: HTTPClientSession) { }

        func get(_ url: String, queryParams: [URLQueryItem]?) async throws -> Data { return Data() }
    }

    struct StubMealRepository: MealRepository {
        var meals: [Meal] = [
            Meal(idMeal: "12345", strMeal: "meal1", strMealThumb: ""),
            Meal(idMeal: "", strMeal: "meal2", strMealThumb: "")
        ]

        var error: Error?

        init(httpClient: HTTPClient, jsonDecoder: JSONDecoding) { }

        func fetchDesserts() async throws -> [Meal] {
            return meals
        }

        func fetchDessert(id: String) async throws -> Recipe {
            if let error: Error = error { throw error }
            return Recipe(idMeal: "", strMeal: "", strMealThumb: "")
        }
    }

    enum StubDecodingError: Error {
        case shouldNotBeCalled
    }

    struct StubJSONDecoding: JSONDecoding {
        func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
            throw StubDecodingError.shouldNotBeCalled
        }
    }

    var viewModel: MealsViewModel!

    @MainActor
    override func setUp() {
        let stubSession: HTTPClientSession = StubHTTPClientSession()
        let stubHTTPClient: HTTPClient = StubHTTPClient(session: stubSession)
        let stubDecoder: JSONDecoding = StubJSONDecoding()
        let mealRepository: MealRepository = StubMealRepository(httpClient: stubHTTPClient,
                                                                jsonDecoder: stubDecoder)
        viewModel = MealsViewModelImpl(mealsRepository: mealRepository)
    }

    @MainActor
    func testInit() {
        XCTAssertEqual(viewModel.title, "Desserts")
        XCTAssertEqual(viewModel.state.value.description, MealsViewState.noData.description)
    }

    @MainActor
    func testNumberOfMeals() async {
        await viewModel.fetchMeals()
        let expected: Int = 2
        let actual: Int = viewModel.numberOfMeals()
        XCTAssertEqual(actual, expected)
    }

    @MainActor
    func testTitleForMeal() async {
        await viewModel.fetchMeals()
        let row: Int = 1
        let expected: String = "meal2"
        let actual: String = viewModel.title(forMealIn: row)
        XCTAssertEqual(actual, expected)
    }

    @MainActor
    func testMealId() async {
        await viewModel.fetchMeals()
        let row: Int = 0
        let expected: String = "12345"
        let actual: String = viewModel.mealId(forMealIn: row)
        XCTAssertEqual(actual, expected)
    }

    // MARK: - fetchMeals() Tests
    enum TestError: Error {
        case someError
    }

    struct FetchMealsInput {
        let meals: [Meal]
        let error: Error?
    }

    struct FetchMealsExpected {
        let states: [MealsViewState]
    }

    let fetchMealsTests: [(input: FetchMealsInput, expected: FetchMealsExpected)] = [
        (
            FetchMealsInput(meals: [
                Meal(idMeal: "12345", strMeal: "meal1", strMealThumb: ""),
                Meal(idMeal: "", strMeal: "meal2", strMealThumb: "")
            ], error: nil),
            FetchMealsExpected(states: [.noData, .loading, .loaded])
        ),
        (
            FetchMealsInput(meals: [], error: nil),
            FetchMealsExpected(states: [.noData, .loading, .noData])
        ),
        (
            FetchMealsInput(meals: [], error: TestError.someError),
            FetchMealsExpected(states: [.noData, .loading, .error("")])
        )
    ]

    @MainActor
    func testFetchMeals() async {
        for testCase in fetchMealsTests {
            let stubSession: HTTPClientSession = StubHTTPClientSession()
            let stubHTTPClient: HTTPClient = StubHTTPClient(session: stubSession)
            let stubDecoder: JSONDecoding = StubJSONDecoding()
            var mealRepository: StubMealRepository = StubMealRepository(httpClient: stubHTTPClient,
                                                                        jsonDecoder: stubDecoder)
            mealRepository.meals = testCase.input.meals
            mealRepository.error = testCase.input.error
            viewModel = MealsViewModelImpl(mealsRepository: mealRepository)

            let expectedStates: [MealsViewState] = testCase.expected.states
            var actualStates: [MealsViewState] = []
            _ = viewModel.state.sink { actualStates.append($0) }
            await viewModel.fetchMeals()
            for (actual, expected) in zip(actualStates, expectedStates) {
                XCTAssertEqual(actual.description, expected.description)
            }
        }
    }
}
