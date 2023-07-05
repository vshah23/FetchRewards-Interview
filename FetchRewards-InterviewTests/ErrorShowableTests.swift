//
//  ErrorShowableTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/5/23.
//

import XCTest

final class ErrorShowableTests: XCTestCase {
    class StubErrorShowable: ErrorShowable {
        let parent: UIViewController
        var viewControllerForDisplay: UIViewController { parent }

        init(parent: UIViewController) {
            self.parent = parent
        }
    }

    var root: UIViewController? {
        let allScenes = UIApplication.shared.connectedScenes

        guard let windowScene: UIWindowScene = allScenes.first as? UIWindowScene,
              let root: UIViewController = windowScene.keyWindow?.rootViewController else {
            return nil
        }
        return root
    }

    override func tearDown() {
        root?.dismiss(animated: false)
    }

    @MainActor
    func testShowError() async {
        let expectation: XCTestExpectation = expectation(description: "completed presenting error")
        guard let root: UIViewController = root else {
            XCTFail("Failed to get root viewController")
            return
        }
        let dummy: StubErrorShowable = StubErrorShowable(parent: root)
        dummy.showError(errorMessage: "Hello, world!") {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 10)
        XCTAssertNotNil(root.presentedViewController)

        let alertController: UIAlertController? = root.presentedViewController as? UIAlertController
        let actualTitle: String? = alertController?.title
        let expectedTitle: String = "MealsDB"
        XCTAssertEqual(actualTitle, expectedTitle)

        let actualMessage: String? = alertController?.message
        let expectedMessage: String = "Hello, world!"
        XCTAssertEqual(actualMessage, expectedMessage)

        XCTAssertEqual(alertController?.actions.count, 1)
        let actualActionTitle: String? = alertController?.actions.first?.title
        let expectedActionTitle: String = "OK"
        XCTAssertEqual(actualActionTitle, expectedActionTitle)
    }

}
