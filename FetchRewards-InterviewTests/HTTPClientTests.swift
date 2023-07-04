//
//  HTTPClientTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/4/23.
//

import XCTest

private let dataToReturn: Data = "Yay!".data(using: .utf8)!

final class HTTPClientTests: XCTestCase {
    struct Input {
        let url: String
        let queryParams: [URLQueryItem]?
        let data: Data?
        let statusCode: Int?
        let errorToThrow: Error?
    }

    struct Expected {
        let data: Data?
        let error: Error?
    }

    let validURL: String = "https://www.google.com"
    let invalidURL: String = "https://www.google.com^"
    let invalidQueryParams: [URLQueryItem] = [URLQueryItem(name: "*", value: "/mnn.json")]

    lazy var cases: [(input: Input, expected: Expected)] = [
        (
            Input(url: validURL,
                  queryParams: nil,
                  data: dataToReturn,
                  statusCode: 200,
                  errorToThrow: nil),
            Expected(data: dataToReturn, error: nil)
        ),
        (
            Input(url: validURL,
                  queryParams: nil,
                  data: dataToReturn,
                  statusCode: 404,
                  errorToThrow: nil),
            Expected(data: nil, error: HTTPClientError.unknown)
        ),
        (
            Input(url: validURL,
                  queryParams: nil,
                  data: nil,
                  statusCode: nil,
                  errorToThrow: URLError(.notConnectedToInternet)),
            Expected(data: nil, error: HTTPClientError.offline)
        ),
        (
            Input(url: validURL,
                  queryParams: nil,
                  data: nil,
                  statusCode: nil,
                  errorToThrow: URLError(.dnsLookupFailed)),
            Expected(data: nil, error: HTTPClientError.unknown)
        ),
        (
            Input(url: invalidURL,
                  queryParams: nil,
                  data: nil,
                  statusCode: nil,
                  errorToThrow: nil),
            Expected(data: nil, error: HTTPClientError.invalidURL)
        ),
        ( // TODO: fix this test case
            Input(url: validURL,
                  queryParams: invalidQueryParams,
                  data: nil,
                  statusCode: nil,
                  errorToThrow: nil),
            Expected(data: nil, error: HTTPClientError.invalidURL)
        )
    ]

    func testGet() async {
        for test in cases {
            let mockSession: StubHTTPClientSession = StubHTTPClientSession(dataToReturn: test.input.data,
                                                                           statusCodeToReturn: test.input.statusCode,
                                                                           errorToThrow: test.input.errorToThrow)

            let client: HTTPClient = HTTPClientImpl(session: mockSession as HTTPClientSession)

            var actualData: Data?
            var actualError: Error?

            do {
                actualData = try await client.get(test.input.url, queryParams: test.input.queryParams)
            } catch {
                actualError = error
            }

            XCTAssertEqual(actualData, test.expected.data)
            XCTAssertEqual(actualError?.localizedDescription, test.expected.error?.localizedDescription)
        }
    }
}

private struct StubHTTPClientSession: HTTPClientSession {
    let dataToReturn: Data?
    let statusCodeToReturn: Int?
    let errorToThrow: Error?

    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        if let errorToThrow: Error = errorToThrow {
            throw errorToThrow
        } else if let dataToReturn: Data = dataToReturn,
                  let statusCodeToReturn: Int = statusCodeToReturn {
            return (dataToReturn, HTTPURLResponse(url: request.url!,
                                                  statusCode: statusCodeToReturn,
                                                  httpVersion: nil,
                                                  headerFields: nil)!)
        } else {
            assertionFailure("Invalid input")
            return (Data(), URLResponse())
        }
    }
}
