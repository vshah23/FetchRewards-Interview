//
//  ErrorShowable.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/30/23.
//

import UIKit

protocol ErrorShowable: AnyObject {
    var parentViewController: UIViewController { get }
    func showError(errorMessage: String)
}

extension ErrorShowable {
    func showError(errorMessage: String) {
        
    }
}
