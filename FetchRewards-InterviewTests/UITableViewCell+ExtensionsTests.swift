//
//  UITableViewCell+ExtensionsTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/4/23.
//

import XCTest

final class UITableViewCellExtensionsTests: XCTestCase {
    class TestTableViewCell: UITableViewCell { }

    func testReuseIdentifier() {
        let expected: String = "TestTableViewCell"
        let actual: String = TestTableViewCell.reuseIdentifier

        XCTAssertEqual(actual, expected)
    }

}
