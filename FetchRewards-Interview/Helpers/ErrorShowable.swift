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

@MainActor
extension ErrorShowable {
    func showError(errorMessage: String) {
        let alertController: UIAlertController = UIAlertController(title: "Meals",
                                                                   message: errorMessage,
                                                                   preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        parentViewController.present(alertController, animated: true)
    }
}
