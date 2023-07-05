//
//  LoadingScreenShowable.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/30/23.
//

import UIKit

protocol LoadingScreenShowable: AnyObject {
    var viewControllerForDisplay: UIViewController { get }
    func showLoader()
    func hideLoader(_ completion: (@Sendable () async -> Void)?) async
}

let loaderViewController: UIViewController = {
    let viewController: UIViewController = UIViewController()

    // setup container view
    let loaderView: UIStackView = UIStackView()
    loaderView.translatesAutoresizingMaskIntoConstraints = false
    loaderView.axis = .vertical
    loaderView.alignment = .center
    loaderView.spacing = UIStackView.spacingUseSystem
    loaderView.backgroundColor = .gray
    loaderView.layer.cornerRadius = 10
    loaderView.isLayoutMarginsRelativeArrangement = true
    loaderView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20,
                                                                  leading: 20,
                                                                  bottom: 20,
                                                                  trailing: 20)

    // setup activity indicator
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.color = .white
    activityIndicator.startAnimating()

    // setup "Loading..." label
    let loadingLabel: UILabel = UILabel()
    loadingLabel.text = "Loading..."
    loadingLabel.textColor = .white
    loadingLabel.numberOfLines = 1
    loadingLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

    // add components to stackview
    loaderView.addArrangedSubview(activityIndicator)
    loaderView.addArrangedSubview(loadingLabel)

    // add the loaderview to our viewcontroller
    viewController.view.addSubview(loaderView)
    viewController.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)

    // constrain to center
    loaderView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor).isActive = true
    loaderView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true

    // set presentation and transition styling
    viewController.modalPresentationStyle = .overCurrentContext
    viewController.modalTransitionStyle = .crossDissolve

    return viewController
}()

@MainActor
extension LoadingScreenShowable {
    func showLoader() {
        guard !loaderViewController.isBeingPresented else { return }
        viewControllerForDisplay.present(loaderViewController, animated: true)
    }

    func hideLoader(_ completion: (@Sendable () async -> Void)? = nil) async {
        guard loaderViewController.isBeingPresented else {
            Task { await completion?() }
            return
        }
        loaderViewController.dismiss(animated: true) {
            Task { await completion?() }
        }
    }
}
