//
//  UITableView+ExtensionsTests.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/4/23.
//

import XCTest

final class UITableViewExtensionsTests: XCTestCase {
    class TestTableViewCell: UITableViewCell { }

    struct StubCellTypeProvider: TableViewCellTypeProvider {
        static var cellTypes: [UITableViewCell.Type] { [TestTableViewCell.self] }
    }

    func testRegisterCells() {
        let cellTypeProvider: TableViewCellTypeProvider.Type = StubCellTypeProvider.self
        let tableView: UITableView = UITableView(frame: .zero)
        tableView.registerCells(for: cellTypeProvider)
        let registeredCellClasses: [String: Any]? = tableView.value(forKey: "_cellClassDict") as? [String: Any]

        // swiftlint:disable:next line_length
        XCTAssertTrue(registeredCellClasses?.contains { $1 as? UITableViewCell.Type == TestTableViewCell.self } ?? false)
    }
}
