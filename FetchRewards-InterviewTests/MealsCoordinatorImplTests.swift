//
//  MealsCoordinatorImplTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/4/23.
//

import XCTest

final class MealsCoordinatorImplTests: XCTestCase {
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
        init(httpClient: HTTPClient, jsonDecoder: JSONDecoding) {
        }

        func fetchDesserts() async throws -> [Meal] {
            return []
        }

        func fetchDessert(id: String) async throws -> Recipe {
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

    var navigationController: UINavigationController!
    var coordinator: Coordinator!

    override func setUp() {
        let session: HTTPClientSession = StubHTTPClientSession()
        let httpClient: HTTPClient = StubHTTPClient(session: session)
        let decoder: JSONDecoding = StubJSONDecoding()
        let repository: MealRepository = StubMealRepository(httpClient: httpClient, jsonDecoder: decoder)

        navigationController = UINavigationController()
        coordinator = MealsCoordinator(navigationController: navigationController,
                                       mealRepository: repository)
    }

    func testStart() {
        coordinator.start()
        XCTAssertTrue(navigationController.viewControllers.contains(where: { $0 is MealsViewController }))
    }

    func testLoadingData() {

    }

    func testParentViewController() {
        let actual: UIViewController? = (coordinator as? LoadingScreenShowable)?.viewControllerForDisplay
        let expected: UINavigationController = navigationController
        XCTAssertEqual(actual, expected)
    }
}
