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
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTextFieldPadding()
    }
    
    private func addTextFieldPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        delegate?.welcomeView(self, didTapNextButton: sender, withEmail: email)
    }
    
}
