//
//  LoadingScreenShowable.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/30/23.
//

import UIKit

protocol LoadingScreenShowable: AnyObject {
    var parentViewController: UIViewController { get }
    func showLoader()
    func hideLoader()
}

extension LoadingScreenShowable {
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
}
