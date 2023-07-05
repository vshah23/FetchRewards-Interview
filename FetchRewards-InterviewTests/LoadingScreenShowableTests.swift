//
//  LoadingScreenShowableTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/5/23.
//

import XCTest

final class LoadingScreenShowableTests: XCTestCase {
    class StubLoadingScreenShowable: LoadingScreenShowable {
        let parent: UIViewController
        var viewControllerForDisplay: UIViewController { parent }

        init(parent: UIViewController) {
            self.parent = parent
        }
    }

    @MainActor
    func testShowLoader() async {
        let loaderViewController: UIViewController = loaderViewController
        let expectation: XCTestExpectation = expectation(description: "completed presenting")

        let allScenes = UIApplication.shared.connectedScenes

        guard let windowScene: UIWindowScene = allScenes.first as? UIWindowScene,
              let root: UIViewController = windowScene.keyWindow?.rootViewController else {
            XCTFail("Failed to get root viewController")
            return
        }

        let dummy: StubLoadingScreenShowable = StubLoadingScreenShowable(parent: root)
        await dummy.showLoader {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 10)
        XCTAssertNotNil(loaderViewController.presentingViewController)
    }

    @MainActor
    func testHideLoader() async {
        let loaderViewController: UIViewController = loaderViewController
        let expectation: XCTestExpectation = expectation(description: "completed dismissing")

        let allScenes = UIApplication.shared.connectedScenes

        guard let windowScene: UIWindowScene = allScenes.first as? UIWindowScene,
              let root: UIViewController = windowScene.keyWindow?.rootViewController else {
            XCTFail("Failed to get root viewController")
            return
        }

        let dummy: StubLoadingScreenShowable = StubLoadingScreenShowable(parent: root)
        await dummy.showLoader {
            await dummy.hideLoader {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 10)
        XCTAssertNil(loaderViewController.presentingViewController)
    }

}
