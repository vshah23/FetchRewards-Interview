//
//  Error+Extensions.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/5/23.
//

import Foundation

/// https://kandelvijaya.com/2018/04/21/blog_equalityonerror/
func areEqual(_ lhs: Error?, _ rhs: Error?) -> Bool {
    if lhs == nil && rhs == nil { return true }
    guard let lhs: Error = lhs, let rhs: Error = rhs else {
        return false
    }
    return lhs.reflectedString == rhs.reflectedString
}

extension Error {
    var reflectedString: String {
        return String(reflecting: self)
    }

    // Same typed Equality
    func isEqual(to error: Self) -> Bool {
        return self.reflectedString == error.reflectedString
    }

}
