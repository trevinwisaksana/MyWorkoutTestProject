//
//  WelcomeView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import UIKit

protocol WelcomeViewDelegate: class {
    func welcomeView(_ view: WelcomeView, didTapNextButton: UIButton, withEmail email: String)
}

final class WelcomeView: UIView {
    
    // MARK: -
    
    weak var delegate: WelcomeViewDelegate?
    
    // MARK: -
    
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - IBAction
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        delegate?.welcomeView(self, didTapNextButton: sender, withEmail: email)
    }
    
}
