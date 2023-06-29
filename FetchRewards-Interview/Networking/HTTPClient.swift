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

typealias HTTPClientResult = Result<HTTPURLResponse, Error>

enum HTTPClientError: Error {
    case invalidURL
    case offline
    case unknown
}

protocol HTTPClient {
    init(session: HTTPClientSession?)
    func get(_ url: String, queryParams: [URLQueryItem]?, completion: @escaping (HTTPClientResult) -> Void)
}

protocol HTTPClientSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: HTTPClientSession { }
