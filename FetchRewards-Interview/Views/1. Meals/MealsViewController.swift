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
    private weak var delegate: MealsViewControllerDelegate?
    private let viewModel: MealsViewModel!
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    private var firstLoadKickedOff: Bool = false

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
        setupTableView()

        title = viewModel.title
        viewModel.state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.update(state: state)
            }
            .store(in: &subscriptions)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !firstLoadKickedOff else { return }
        refreshData()
        firstLoadKickedOff = true
    }

    private func setupTableView() {
        tableView.registerCells(for: type(of: self))
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(refreshData),
                                            for: .valueChanged)
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Fetching recipes...",
                                                                       attributes: nil)
    }
}

// MARK: - Datasource
extension MealsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfMeals()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier,
                                                                  for: indexPath)
        cell.textLabel?.text = viewModel.titleForMeal(in: indexPath.row)
        return cell
    }
}

// MARK: - Delegate
extension MealsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.mealSelected(id: viewModel.mealId(forMealAt: indexPath.row))
    }
}

extension MealsViewController {
    private func update(state: MealsViewState) {
        switch state {
        case .loading:
            setLoadingState()
        case .loaded:
            setLoadedState()
        case .noData:
            setNoDataState()
        case .error(let errorMessage):
            setErrorState(errorMessage)
        }
    }

    private func setLoadingState() {
        delegate?.loadingData()
    }

    private func setLoadedState() {
        delegate?.finishedLoadingData()
        tableView.refreshControl?.endRefreshing()
        removeEmptyMessage()
        tableView.dataSource = self
        tableView.reloadData()
    }

    private func setNoDataState() {
        tableView.refreshControl?.endRefreshing()
        setEmptyMessage("No recipes found!")
        tableView.reloadData()
    }

    private func setErrorState(_ errorMessage: String) {
        delegate?.errorLoadingData(errorMessage: errorMessage)
    }

    @objc
    private func refreshData() {
        Task { [weak self] in
            await self?.viewModel.fetchMeals()
        }
    }

    private func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: tableView.bounds.size.width,
                                                 height: tableView.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        tableView.backgroundView = messageLabel
    }

    private func removeEmptyMessage() {
        tableView.backgroundView = nil
    }
}

extension MealsViewController: TableViewCellTypeProvider {
    static var cellTypes: [UITableViewCell.Type] { [UITableViewCell.self] }
}
