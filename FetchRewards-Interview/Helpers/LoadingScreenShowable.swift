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

let loaderViewController: UIViewController = {
    let vc: UIViewController = UIViewController()
    
    // setup container view
    let loaderView: UIStackView = UIStackView()
    loaderView.translatesAutoresizingMaskIntoConstraints = false
    loaderView.axis = .vertical
    loaderView.alignment = .center
    loaderView.spacing = UIStackView.spacingUseSystem
    loaderView.isLayoutMarginsRelativeArrangement = true
    loaderView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20,
                                                                  leading: 20,
                                                                  bottom: 20,
                                                                  trailing: 20)
    loaderView.backgroundColor = .gray
    loaderView.layer.cornerRadius = 10

    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.color = .white
    activityIndicator.startAnimating()
    
    let loadingLabel: UILabel = UILabel()
    loadingLabel.text = "Loading..."
    loadingLabel.textColor = .white
    loadingLabel.numberOfLines = 1
    loadingLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    
    loaderView.addArrangedSubview(activityIndicator)
    loaderView.addArrangedSubview(loadingLabel)
    
    vc.view.addSubview(loaderView)
    vc.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    loaderView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
    loaderView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
    
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    
    return vc
}()

extension LoadingScreenShowable {
    @MainActor
    func showLoader() {
        parentViewController.present(loaderViewController, animated: true)
    }
    
    @MainActor
    func hideLoader() {
        loaderViewController.presentingViewController?.dismiss(animated: true)
    }
}
