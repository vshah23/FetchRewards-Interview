//
//  LoadingScreenShowable.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/30/23.
//

import UIKit

protocol LoadingScreenShowable: AnyObject {
    var parentViewController: UIViewController { get }
    @MainActor func showLoader()
    @MainActor func hideLoader() async
}

let loaderViewController: UIViewController = {
    let vc: UIViewController = UIViewController()
    
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
    vc.view.addSubview(loaderView)
    vc.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    // constrain to center
    loaderView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
    loaderView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
    
    // set presentation and transition styling
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    
    return vc
}()

// TODO: Allow cancelling loader
extension LoadingScreenShowable {
    @MainActor
    func showLoader() {
        parentViewController.present(loaderViewController, animated: true)
    }
    
    @MainActor
    func hideLoader() async {
        // Suspend the current task, and pass its continuation into a closure
        // that executes immediately
        _ = await withUnsafeContinuation { continuation in
            // Invoke the synchronous callback-based API...
            loaderViewController.presentingViewController?.dismiss(animated: true) {
                // ...and resume the continuation when the callback is invoked
                continuation.resume(returning: true)
            }
        }
    }
}
