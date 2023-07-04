//
//  UITableView+Extensions.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 7/3/23.
//

import UIKit

extension UITableView {
    func registerCells(for cellTypeProvider: TableViewCellTypeProvider.Type) {
        for type in cellTypeProvider.cellTypes {
            register(type.self,
                     forCellReuseIdentifier: type.reuseIdentifier)
        }
    }
}
