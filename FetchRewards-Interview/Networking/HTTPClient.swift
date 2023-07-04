//
//  HTTPClient.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation

private enum HTTPMethod: String {
    case GET
}

enum HTTPClientError: Error {
    case invalidURL
    case offline
    case unknown
}

protocol HTTPClient {
    init(session: HTTPClientSession)
    func get(_ url: String, queryParams: [URLQueryItem]?) async throws -> Data
}

protocol HTTPClientSession {
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: HTTPClientSession { }

final class HTTPClientImpl: HTTPClient {
    private let session: HTTPClientSession

    init(session: HTTPClientSession) {
        self.session = session
    }

    private func performRequest(request: URLRequest) async throws -> Data {
        do {
            let (data, response): (Data, URLResponse) = try await session.data(for: request,
                                                                               delegate: nil)

            if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                return data
            } else {
                throw HTTPClientError.unknown
            }
        } catch {
            if let error: URLError = error as? URLError, error.errorCode == NSURLErrorNotConnectedToInternet {
                throw HTTPClientError.offline
            } else {
                throw HTTPClientError.unknown
            }
        }
    }
}

extension HTTPClientImpl {
    func get(_ url: String, queryParams: [URLQueryItem]? = nil) async throws -> Data {
        guard var urlComponents: URLComponents = URLComponents(string: url) else {
            throw HTTPClientError.invalidURL
        }

        urlComponents.queryItems = queryParams

        guard let url: URL = urlComponents.url else {
            throw HTTPClientError.invalidURL
        }

        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue

        return try await performRequest(request: request)
    }
}
