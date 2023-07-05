//
//  MealDetailsViewController.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/29/23.
//

import UIKit

class MealDetailsViewController: UITableViewController {
    private enum MealDetailsSection: Int, CaseIterable {
        case instructions = 0
        case ingredients

        var headerTitle: String {
            switch self {
            case .instructions:
                return "Instructions"
            case .ingredients:
                return "Ingredients"
            }
        }
    }

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
        setupView()
    }

    private func setupView() {
        title = viewModel.title
        setupTableView()
    }

    private func setupTableView() {
        tableView.registerCells(for: type(of: self))
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
}

// MARK: - Datasource
extension MealDetailsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MealDetailsSection.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case MealDetailsSection.instructions.rawValue:
            return viewModel.numberOfInstructions
        case MealDetailsSection.ingredients.rawValue:
            return viewModel.numberOfIngredients
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier,
                                                                  for: indexPath)
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            return setupInstructionsCell(cell, for: indexPath)
        case (1, _):
            return setupIngredientCell(cell, for: indexPath)
        default:
            return UITableViewCell()
        }
    }

    private func setupInstructionsCell(_ cell: UITableViewCell, for indexPath: IndexPath) -> UITableViewCell {
        cell.textLabel?.text = viewModel.instructionsText(for: indexPath.row)
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    private func setupIngredientCell(_ cell: UITableViewCell, for indexPath: IndexPath) -> UITableViewCell {
        cell.textLabel?.text = viewModel.ingredientText(for: indexPath.row)
        cell.textLabel?.numberOfLines = 1
        return cell
    }
}

// MARK: - Delegate
extension MealDetailsViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < MealDetailsSection.allCases.count else { return nil }
        return MealDetailsSection(rawValue: section)?.headerTitle
    }
}

extension MealDetailsViewController: TableViewCellTypeProvider {
    static var cellTypes: [UITableViewCell.Type] { [UITableViewCell.self] }
}
