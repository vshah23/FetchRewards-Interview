//
//  MealRepository.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation

protocol MealRepository {
    init(httpClient: HTTPClient, jsonDecoder: JSONDecoding)
    func fetchDesserts() async throws -> [Recipe]
    func fetchDessert(id: String) async throws -> Recipe
}

enum MealDBAPI {
    static let baseURL: String = "https://themealdb.com/api/json/v1/1"
    static let filterEndpoint: String = "/filter.php"
    static let recipeLookupEndpoint: String = "/lookup.php"
}

enum MealRepositoryError: Error {
    case recipeNotFound
}

final class MealRepositoryImpl: MealRepository {
    let httpClient: HTTPClient
    let jsonDecoder: JSONDecoding

    init(httpClient: HTTPClient, jsonDecoder: JSONDecoding) {
        self.httpClient = httpClient
        self.jsonDecoder = jsonDecoder
    }

    func fetchDesserts() async throws -> [Recipe] {
        let url: String = MealDBAPI.baseURL + MealDBAPI.filterEndpoint
        let queryParams: [URLQueryItem] = [URLQueryItem(name: "c", value: "Dessert")]
        let data: Data = try await httpClient.get(url, queryParams: queryParams)

        let menu: Menu = try jsonDecoder.decode(Menu.self, from: data)
        return menu.meals
    }

    func fetchDessert(id: String) async throws -> Recipe {
        let url: String = MealDBAPI.baseURL + MealDBAPI.recipeLookupEndpoint
        let queryParams: [URLQueryItem] = [URLQueryItem(name: "i", value: id)]
        let data: Data = try await httpClient.get(url, queryParams: queryParams)

        let menu: Menu = try JSONDecoder().decode(Menu.self, from: data)
        guard let recipe: Recipe = menu.meals.first else {
            throw MealRepositoryError.recipeNotFound
        }

        return recipe
    }
}
