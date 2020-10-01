//
//  SignUpPresenter.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import Foundation

final class SignUpPresenter {
    
    var presenter: SignUpViewController
    
    init(_ presenter: SignUpViewController) {
        self.presenter = presenter
    }

    func presentProfileScreen() {
        presenter.navigationController?.pushViewController(SignUpViewController(email: ""), animated: true)
    }
    
}
