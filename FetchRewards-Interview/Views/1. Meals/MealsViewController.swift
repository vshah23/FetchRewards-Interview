//
//  MealsViewController.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/28/23.
//

import UIKit
import Combine

protocol MealsViewControllerDelegate: AnyObject {
    func loadingData()
    func finishedLoadingData()
    func errorLoadingData(errorMessage: String)
    func mealSelected(id: String)
}

class MealsViewController: UITableViewController {
    weak var delegate: MealsViewControllerDelegate?
    let viewModel: MealsViewModel!
    var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(viewModel: MealsViewModel, delegate: MealsViewControllerDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("We're not using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = viewModel.title
        viewModel.state.sink { [weak self] state in
            self?.update(state: state)
        }.store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { await viewModel.fetchMeals() }
    }
}

extension MealsViewController {
    private func update(state: MealsViewState) {
        switch state {
        case .loading:
            setLoadingState()
        case .loaded:
            setLoadedState()
        case .error(let errorMessage):
            setErrorState(errorMessage)
        }
    }
    
    private func setLoadingState() {
        delegate?.loadingData()
    }
    
    private func setLoadedState() {
        delegate?.finishedLoadingData()
        tableView.reloadData()
    }
    
    private func setErrorState(_ errorMessage: String) {
        delegate?.errorLoadingData(errorMessage: errorMessage)
    }

}

