//
//  ErrorHelperTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/3/23.
//

import XCTest

final class ErrorHelperTests: XCTestCase {
    func testOfflineError() {
        let error: Error = HTTPClientError.offline
        let message: String = ErrorHelper.userFriendlyErrorMessage(for: error)
        XCTAssertEqual(message, "Please check your network connection and try again.")
    }

    func testDefaultError() {
        enum SomeError: Error {
            case randomError
        }
        let error: Error = SomeError.randomError
        let message: String = ErrorHelper.userFriendlyErrorMessage(for: error)
        XCTAssertEqual(message, "Sorry, something went wrong. Please try again.")
    }

 }
