//
//  Extension + VC.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

extension UIViewController {
    func showLoadingView(on loadingBGView: UIView) {
        view.addSubview(loadingBGView)
        loadingBGView.pin(to: view)
        loadingBGView.backgroundColor = .systemBackground
        loadingBGView.alpha = 0
        
        let loader = UIView()
        loadingBGView.addSubview(loader)
        
        UIView.animate(withDuration: 0.25) {
            loadingBGView.alpha = 0.8
        }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingBGView.addSubview(activityIndicator)
        
        activityIndicator.centerView(on: loadingBGView, axis: .both)
        
        loader.centerView(on: loadingBGView, axis: .both)
        loader.configureSize(width: 100, height: 100)
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(view loadingBGView: UIView) {
        DispatchQueue.main.async {
            loadingBGView.subviews.forEach { newView in
                newView.removeFromSuperview()
            }
            loadingBGView.removeFromSuperview()
        }
        
    }
    
    func showEmptyStateView(with message: String) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            addChild(childVC)
            containerView.addSubview(childVC.view)
            childVC.view.frame = containerView.bounds
            childVC.didMove(toParent: self)
        }
    }
}
