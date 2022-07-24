//
//  GFDataLoadingVC.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 25.07.2022.
//

import UIKit

class GFDataLoadingVC: UIViewController {

    var containerView: UIView!
    
    func showLoading() {
        containerView = UIView(frame: view.bounds)
        view?.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
    
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

    func showEmptyStateView(with message:String, view: UIView) {
        let emptyStateView: GFEmptyStateView = GFEmptyStateView(message: message)
        
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}