//
//  Menu.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/28/23.
//

import Foundation

struct Menu<T: Codable>: Codable {
    let meals: [T]
}
