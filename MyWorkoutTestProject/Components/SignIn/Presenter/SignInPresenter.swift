//
//  SignInPresenter.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import UIKit

final class SignInPresenter {
    
    var presenter: SignInViewController
    
    init(_ presenter: SignInViewController) {
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
