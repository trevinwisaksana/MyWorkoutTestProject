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
    func keyboardDidHide(in view: SignInView)
}

final class SignInView: UIView {
    
    // MARK: -
    
    weak var delegate: SignInViewDelegate?
    
    // MARK: -
    
    @IBOutlet weak var loginInLabel: UILabel!
    @IBOutlet weak var nextIconImageView: UIImageView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageViewCenterYConstraint: NSLayoutConstraint!
    
    private let originalLogInButtonBottomMargin: CGFloat = 40
    
    var isKeyboardPresented: Bool = false
    
    // MARK: - Properties
    
    lazy var toastView: ToastView = {
        let nibName = String(describing: ToastView.self)
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! ToastView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
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
    
    func resignTextField() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func showError(message: String) {
        toastView.show(withMessage: message, at: .top)
    }
    
    func showLoadingIndicator() {
        logInButton.isEnabled = false
        loginInLabel.isHidden = true
        nextIconImageView.isHidden = true
        
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: logInButton.centerYAnchor)
        ])
    }
    
    func hideLoadingIndicator() {
        logInButton.isEnabled = true
        loginInLabel.isHidden = false
        nextIconImageView.isHidden = false
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    // MARK: - Keyboard
    
    func setupKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func removeKeyboardListener() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            deployTextField(by: keyboardSize.height)
        }
        
        isKeyboardPresented = true
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        widthdrawTextField()
    }
    
    @objc
    func keyboardDidHide(notification: NSNotification) {
        isKeyboardPresented = false
        
        delegate?.keyboardDidHide(in: self)
    }
    
    func deployTextField(by value: CGFloat) {
        guard !isKeyboardPresented else {
            return
        }
        
        let window = UIApplication.shared.windows.first
        let bottomPadding = (window?.safeAreaInsets.bottom ?? .zero) - logInButtonBottomConstraint.constant
        
        logInButtonBottomConstraint.constant = (value - bottomPadding)
        logoImageViewCenterYConstraint.constant = -value
        
        layoutIfNeeded()
    }
    
    func widthdrawTextField() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                /// 50 is the original constraint position
                self.logInButtonBottomConstraint.constant = self.originalLogInButtonBottomMargin
                self.logoImageViewCenterYConstraint.constant = .zero
                
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        delegate?.signInView(self, didTapCancelButton: sender)
    }
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        delegate?.signInView(self, didTapSignUpButton: sender)
    }
    
}

// MARK: - UITextFieldDelegate

extension SignInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
