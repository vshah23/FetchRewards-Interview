//
//  TableViewCellTypeProvider.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 7/3/23.
//

import UIKit

protocol TableViewCellTypeProvider {
    static var cellTypes: [UITableViewCell.Type] { get }
}
