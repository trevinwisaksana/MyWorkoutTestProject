//
//  SignUpView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

protocol SignUpViewDelegate: class {
    func signUpView(_ view: SignUpView, didTapCancelButton: UIButton)
    func signUpView(_ view: SignUpView, didTapSignUpButton: UIButton)
}

final class SignUpView: UIView {
    
    // MARK: -
    
    weak var delegate: SignUpViewDelegate?
    
    var genderSelected: Gender?
    
    // MARK: -
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTextFieldPadding()
        setGenderButtonIcons()
    }
    
    private func addTextFieldPadding() {
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftView = emailPaddingView
        emailTextField.leftViewMode = .always
        
        let passwordPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = .always
    }
    
    private func setGenderButtonIcons() {
        let fillImage = UIImage(systemName: "circle.fill")
        
        let symbolConfig = UIImage.SymbolConfiguration(weight: .ultraLight)
        let nonFillImage = UIImage(systemName: "circle", withConfiguration: symbolConfig)
        
        femaleButton.setBackgroundImage(fillImage, for: .selected)
        maleButton.setBackgroundImage(fillImage, for: .selected)
        
        femaleButton.setBackgroundImage(nonFillImage, for: .normal)
        maleButton.setBackgroundImage(nonFillImage, for: .normal)
    }
    
    func email() -> String? {
        return emailTextField.text
    }
    
    func password() -> String? {
        return emailTextField.text
    }
    
    func genderSelected() -> Gender? {
        return genderSelected
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapFemaleButton(_ sender: UIButton) {
        genderSelected = .female
        
        sender.isSelected = true
        maleButton.isSelected = false
    }
    
    @IBAction func didTapMaleButton(_ sender: UIButton) {
        genderSelected = .male
        
        sender.isSelected = true
        femaleButton.isSelected = false
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        delegate?.signUpView(self, didTapCancelButton: sender)
    }
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        delegate?.signUpView(self, didTapSignUpButton: sender)
    }
    
}
