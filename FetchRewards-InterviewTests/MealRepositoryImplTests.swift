//
//  MealRepositoryImplTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/5/23.
//

import XCTest

final class MealRepositoryImplTests: XCTestCase {
    struct StubHTTPClientSession: HTTPClientSession {
        func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
            return (Data(), URLResponse())
        }
    }

    struct StubHTTPClient: HTTPClient {
        var dataToReturn: Data?
        var errorToThrow: Error?

        init(session: HTTPClientSession) { }

        func get(_ url: String, queryParams: [URLQueryItem]?) async throws -> Data {
            if let error: Error = errorToThrow { throw error } else if let dataToReturn: Data = dataToReturn {
                return dataToReturn
            } else { throw TestError.failedToReturnStub }
        }
    }

    enum TestError: Error {
        /// A dummy error value.
        case testError

        /// Something failed in the tests.
        case failedToReturnStub
    }

    struct StubJSONDecoding: JSONDecoding {
        var objectToReturn: Decodable?
        var errorToThrow: Error?

        func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
            if let error: Error = errorToThrow { throw error } else if let objectToReturn: T = objectToReturn as? T {
                return objectToReturn
            } else { throw TestError.failedToReturnStub }
        }
    }

    // MARK: - fetchDesserts Tests
    struct FetchDessertsInput {
        let data: Data?
        let httpClientError: Error?
        let decodeObjectToReturn: Menu?
        let decodeError: Error?
    }

    struct FetchDessertsExpected {
        let recipes: [Recipe]?
        let error: Error?
    }

    let recipe1: Recipe = Recipe(idMeal: "", strMeal: "", strMealThumb: "")
    var recipes1: [Recipe] { [recipe1] }
    var menu1: Menu { Menu(meals: recipes1) }
    var menu2: Menu { Menu(meals: []) }

    lazy var fetchDessertsTests: [(input: FetchDessertsInput, expected: FetchDessertsExpected)] = [
        (
            FetchDessertsInput(data: Data(),
                               httpClientError: nil,
                               decodeObjectToReturn: menu1,
                               decodeError: nil),
            FetchDessertsExpected(recipes: recipes1, error: nil)
        ),
        (
            FetchDessertsInput(data: nil,
                               httpClientError: TestError.testError,
                               decodeObjectToReturn: nil,
                               decodeError: nil),
            FetchDessertsExpected(recipes: nil, error: TestError.testError)
        ),
        (
            FetchDessertsInput(data: Data(),
                               httpClientError: nil,
                               decodeObjectToReturn: nil,
                               decodeError: TestError.testError),
            FetchDessertsExpected(recipes: nil, error: TestError.testError)
        )
    ]

    func testFetchDesserts() async {
        for testCase in fetchDessertsTests {
            let stubSession: HTTPClientSession = StubHTTPClientSession()
            var stubHTTPClient: StubHTTPClient = StubHTTPClient(session: stubSession)
            var stubDecoder: StubJSONDecoding = StubJSONDecoding()
            stubHTTPClient.dataToReturn = testCase.input.data
            stubHTTPClient.errorToThrow = testCase.input.httpClientError
            stubDecoder.objectToReturn = testCase.input.decodeObjectToReturn
            stubDecoder.errorToThrow = testCase.input.decodeError
            let repository: MealRepository = MealRepositoryImpl(httpClient: stubHTTPClient, jsonDecoder: stubDecoder)

            var actualRecipes: [Recipe]?
            var actualError: Error?

            do {
                actualRecipes = try await repository.fetchDesserts()
            } catch {
                actualError = error
            }

            XCTAssertEqual(actualRecipes, testCase.expected.recipes)
            // swiftlint:disable:next line_length
            XCTAssertTrue(areEqual(actualError, testCase.expected.error), "actual error:\(String(describing: actualError)), expected error:\(String(describing: testCase.expected.error))")
        }
    }

    // MARK: - fetchDessert() Tests

    // MARK: - fetchDesserts Tests
    struct FetchDessertInput {
        let data: Data?
        let httpClientError: Error?
        let decodeObjectToReturn: Menu?
        let decodeError: Error?
    }

    struct FetchDessertExpected {
        let recipe: Recipe?
        let error: Error?
    }

    lazy var fetchDessertTests: [(input: FetchDessertInput, expected: FetchDessertExpected)] = [
        (
            FetchDessertInput(data: Data(),
                              httpClientError: nil,
                              decodeObjectToReturn: menu1,
                              decodeError: nil),
            FetchDessertExpected(recipe: recipe1, error: nil)
        ),
        (
            FetchDessertInput(data: nil,
                              httpClientError: TestError.testError,
                              decodeObjectToReturn: nil,
                              decodeError: nil),
            FetchDessertExpected(recipe: nil, error: TestError.testError)
        ),
        (
            FetchDessertInput(data: Data(),
                              httpClientError: nil,
                              decodeObjectToReturn: nil,
                              decodeError: TestError.testError),
            FetchDessertExpected(recipe: nil, error: TestError.testError)
        ),
        (
            FetchDessertInput(data: Data(),
                              httpClientError: nil,
                              decodeObjectToReturn: menu2,
                              decodeError: nil),
            FetchDessertExpected(recipe: nil, error: MealRepositoryError.invalidRecipe)
        )
    ]

    func testFetchDessert() async {
        for testCase in fetchDessertTests {
            let stubSession: HTTPClientSession = StubHTTPClientSession()
            var stubHTTPClient: StubHTTPClient = StubHTTPClient(session: stubSession)
            var stubDecoder: StubJSONDecoding = StubJSONDecoding()
            stubHTTPClient.dataToReturn = testCase.input.data
            stubHTTPClient.errorToThrow = testCase.input.httpClientError
            stubDecoder.objectToReturn = testCase.input.decodeObjectToReturn
            stubDecoder.errorToThrow = testCase.input.decodeError
            let repository: MealRepository = MealRepositoryImpl(httpClient: stubHTTPClient, jsonDecoder: stubDecoder)

            var actualRecipe: Recipe?
            var actualError: Error?

            do {
                actualRecipe = try await repository.fetchDessert(id: "")
            } catch {
                actualError = error
            }

            XCTAssertEqual(actualRecipe, testCase.expected.recipe)
            // swiftlint:disable:next line_length
            XCTAssertTrue(areEqual(actualError, testCase.expected.error), "actual error:\(String(describing: actualError)), expected error:\(String(describing: testCase.expected.error))")
        }
    }
}
