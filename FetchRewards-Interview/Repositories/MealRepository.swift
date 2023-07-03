//
//  MealRepository.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation

protocol MealRepository {
    init(httpClient: HTTPClient)
    func fetchDesserts() async throws -> [Meal]
    func fetchDessert(id: String) async throws -> Recipe
}

enum MealDBAPI {
    static let baseURL: String = "https://themealdb.com/api/json/v1/1"
    static let filterEndpoint: String = "/filter.php"
    static let recipeLookupEndpoint: String = "/lookup.php"
}

enum MealRepositoryError: Error {
    case badData
}

final class MealRepositoryImpl: MealRepository {
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func fetchDesserts() async throws -> [Meal] {
        let url: String = MealDBAPI.baseURL + MealDBAPI.filterEndpoint
        let queryParams: [URLQueryItem] = [URLQueryItem(name: "c", value: "Dessert")]
        let data: Data = try await httpClient.get(url, queryParams: queryParams)
        
        //TODO: decouple JSONDecoder
        let menu: Menu<Meal> = try JSONDecoder().decode(Menu<Meal>.self, from: data)
        return menu.meals
    }
    
    func fetchDessert(id: String) async throws -> Recipe {
        let url: String = MealDBAPI.baseURL + MealDBAPI.recipeLookupEndpoint
        let queryParams: [URLQueryItem] = [URLQueryItem(name: "i", value: id)]
        let data: Data = try await httpClient.get(url, queryParams: queryParams)
        
        let menu: Menu<Recipe> = try JSONDecoder().decode(Menu<Recipe>.self, from: data)
        guard let recipe: Recipe = menu.meals.first else {
            throw MealRepositoryError.badData
        }
        
        return recipe
    }
}
