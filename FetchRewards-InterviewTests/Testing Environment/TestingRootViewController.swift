//
//  TestingRootViewController.swift
//  FetchRewards-InterviewTests
//
//  Created by Vikas Shah on 7/4/23.
//

import UIKit

class TestingRootViewController: UIViewController {

    override func loadView() {
        let label = UILabel()
        label.text = "Running Unit Tests..."
        label.textAlignment = .center
        label.textColor = .white

        view = label
    }
}
