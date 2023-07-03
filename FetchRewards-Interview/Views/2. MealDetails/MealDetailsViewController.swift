//
//  MealDetailsViewController.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import UIKit

class MealDetailsViewController: UIViewController {
    private let viewModel: MealDetailsViewModel!
    
    init(viewModel: MealDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("We're not using storyboards.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .white
    }
}
