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

struct HTTPClientImpl: HTTPClient {
    let session: HTTPClientSession
    
    init(session: HTTPClientSession?) {
        guard let session: HTTPClientSession = session else {
            self.session = URLSession(configuration: .default)
            return
        }

        self.session = session
    }
    
    func performRequest(request: URLRequest, _ completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let error: URLError = error as? URLError, error.errorCode == NSURLErrorNotConnectedToInternet {
                completion(.failure(HTTPClientError.offline))
            } else if let response: HTTPURLResponse = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                completion(.success(response))
            } else {
                completion(.failure(HTTPClientError.unknown))
            }
        }).resume()
    }
    
}

extension HTTPClientImpl {
    func get(_ url: String, queryParams: [URLQueryItem]?, completion: @escaping (HTTPClientResult) -> Void) {
        guard var urlComponents: URLComponents = URLComponents(string: url) else {
            completion(.failure(HTTPClientError.invalidURL))
            return
        }
        
        urlComponents.queryItems = queryParams
        
        guard let url: URL = urlComponents.url else {
            completion(.failure(HTTPClientError.invalidURL))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        performRequest(request: request, completion)
    }
}
