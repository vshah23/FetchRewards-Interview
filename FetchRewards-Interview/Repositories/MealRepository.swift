//
//  MealRepository.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation

protocol MealRepository {
    init(httpClient: HTTPClient)
    func fetchDesserts() async throws -> Menu
//    func fetchDessert(id: String) async throws -> Recipe
}

enum MealDBAPI {
    static let baseURL: String = "https://themealdb.com/api/json/v1/1"
    static let filterEndpoint: String = "/filter.php"
}

final class MealRepositoryImpl: MealRepository {
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func fetchDesserts() async throws -> Menu {
        let url: String = MealDBAPI.baseURL + MealDBAPI.filterEndpoint
        let queryParams: [URLQueryItem] = [URLQueryItem(name: "c", value: "Dessert")]
        let data: Data = try await httpClient.get(url, queryParams: queryParams)
        
        //TODO decouple JSONDecoder
        return try JSONDecoder().decode(Menu.self, from: data)
    }
    
//    func fetchDessert(id: String) async throws -> Recipe {
//        return Recipe()
//    }
}
