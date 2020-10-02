//
//  SignInPresenter.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class SignInPresenter {
    
    var presenter: SignInViewController
    
    init(_ presenter: SignInViewController) {
        self.presenter = presenter
    }

    func presentProfileScreen() {
        presenter.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
}
