//
//  MealsCoordinatorTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/4/23.
//

import XCTest

final class MealsCoordinatorImplTests: XCTestCase {
    struct StubHTTPClientSession: HTTPClientSession {
        func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) { return (Data(), URLResponse()) }
    }

    struct StubHTTPClient: HTTPClient {
        init(session: HTTPClientSession) { }

        func get(_ url: String, queryParams: [URLQueryItem]?) async throws -> Data { return Data() }
    }

    struct StubMealRepository: MealRepository {
        init(httpClient: HTTPClient, jsonDecoder: JSONDecoding) {
        }

        func fetchDesserts() async throws -> [Recipe] {
            return []
        }

        func fetchDessert(id: String) async throws -> Recipe {
            return Recipe(idMeal: "", strMeal: "", strMealThumb: "")
        }
    }

    struct StubJSONDecoding: JSONDecoding {
        func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {  }
    }

    func testStart() {
        let session: HTTPClientSession = StubHTTPClientSession()
        let httpClient: HTTPClient = StubHTTPClient(session: session)
        let decoder: JSONDecoding = StubJSONDecoding()
        let repository: MealRepository = StubMealRepository(httpClient: httpClient, jsonDecoder: decoder)

    }
}
