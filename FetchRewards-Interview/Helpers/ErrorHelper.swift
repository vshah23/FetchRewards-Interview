//
//  ErrorHelper.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 7/3/23.
//

import Foundation

enum ErrorHelper {
    static func userFriendlyErrorMessage(for error: Error) -> String {
        switch error {
        case HTTPClientError.offline:
            return "Please check your network connection and try again."
        default:
            return "Sorry, something went wrong. Please try again."
        }
    }
}
