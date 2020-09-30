//
//  WelcomePresenter.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import Foundation

final class WelcomePresenter {
    
    var presenter: WelcomeViewController
    
    init(_ presenter: WelcomeViewController) {
        self.presenter = presenter
    }
    
    func presentWelcomeBackScreen() {
        presenter.navigationController?.pushViewController(WelcomeViewController(), animated: true)
    }
    
    func presentSignUpScreen() {
        presenter.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
}
