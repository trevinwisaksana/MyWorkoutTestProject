//
//  SignInView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import UIKit

protocol SignInViewDelegate: class {
    func signInView(_ view: SignInView, didTapCancelButton: UIButton)
    func signInView(_ view: SignInView, didTapSignUpButton: UIButton)
}

final class SignInView: UIView {
    
    // MARK: -
    
    weak var delegate: SignInViewDelegate?
    
    // MARK: -
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTextFieldPadding()
    }
    
    private func addTextFieldPadding() {
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftView = emailPaddingView
        emailTextField.leftViewMode = .always
        
        let passwordPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = .always
    }
    
    func email() -> String? {
        return emailTextField.text
    }
    
    func password() -> String? {
        return passwordTextField.text
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        delegate?.signInView(self, didTapCancelButton: sender)
    }
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        delegate?.signInView(self, didTapSignUpButton: sender)
    }
    
}
