//
//  SignUpView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

protocol SignUpViewDelegate: class {
    func signUpView(_ view: SignUpView, didTapCancelButton: UIButton)
    func signUpView(_ view: SignUpView, didTapNextButton: UIButton)
}

final class SignUpView: UIView {
    
    // MARK: -
    
    weak var delegate: SignUpViewDelegate?
    
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
    
    // MARK: - IBAction
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        
    }
    
}
