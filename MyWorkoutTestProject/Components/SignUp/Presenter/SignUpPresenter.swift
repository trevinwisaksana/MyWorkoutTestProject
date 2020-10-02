//
//  SignUpPresenter.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

final class SignUpPresenter {
    
    var presenter: SignUpViewController
    
    init(_ presenter: SignUpViewController) {
        self.presenter = presenter
    }

    func presentProfileScreen() {
        guard let window = presenter.view.window, let sceneDelegate = window.windowScene?.delegate as? SceneDelegate else {
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let navigationController = UINavigationController(rootViewController: ProfileViewController())
            navigationController.navigationBar.isHidden = true
            
            sceneDelegate.window?.rootViewController = navigationController
            
        }, completion: nil)
    }
    
}
