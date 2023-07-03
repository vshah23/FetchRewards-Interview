//
//  JSONDelegate.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 7/3/23.
//

import Foundation

protocol JSONDecoding {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: JSONDecoding { }
