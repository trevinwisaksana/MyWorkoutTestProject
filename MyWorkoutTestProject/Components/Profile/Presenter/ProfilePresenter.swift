//
//  ProfilePresenter.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import UIKit

final class ProfilePresenter {
    
    var presenter: ProfileViewController
    
    init(_ presenter: ProfileViewController) {
        self.presenter = presenter
    }
    
    func presentWelcomeScreen() {
        guard let window = presenter.view.window, let sceneDelegate = window.windowScene?.delegate as? SceneDelegate else {
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let navigationController = UINavigationController(rootViewController: WelcomeViewController())
            navigationController.navigationBar.isHidden = true
            
            sceneDelegate.window?.rootViewController = navigationController
            
        }, completion: nil)
    }
    
}
