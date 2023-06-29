//
//  MealRepository.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import Foundation

protocol MealRepository {
    init(httpClient: HTTPClient)
    func fetchDesserts()
    func fetchDessert(id: String)
}
