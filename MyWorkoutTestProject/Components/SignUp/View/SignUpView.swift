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
    func keyboardDidHide(in view: SignUpView)
}

final class SignUpView: UIView {
    
    // MARK: -
    
    weak var delegate: SignUpViewDelegate?
    
    var genderSelected: Gender?
    
    // MARK: -
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var nextIconImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    
    @IBOutlet weak var signUpButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageViewCenterYConstraint: NSLayoutConstraint!
    
    private let originalSignUpButtonBottomMargin: CGFloat = 40
    
    var isKeyboardPresented: Bool = false
    
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
        let fillImage = UIImage(systemName: "checkmark.circle.fill")
        
        let symbolConfig = UIImage.SymbolConfiguration(weight: .ultraLight)
        let nonFillImage = UIImage(systemName: "circle", withConfiguration: symbolConfig)
        
        femaleButton.setBackgroundImage(fillImage, for: .selected)
        maleButton.setBackgroundImage(fillImage, for: .selected)
        
        femaleButton.setBackgroundImage(nonFillImage, for: .normal)
        maleButton.setBackgroundImage(nonFillImage, for: .normal)
        
        femaleButton.tintColor = .lightGray
        maleButton.tintColor = .lightGray
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
        signUpButton.isEnabled = false
        signUpLabel.isHidden = true
        nextIconImageView.isHidden = true
        
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor)
        ])
    }
    
    func hideLoadingIndicator() {
        signUpButton.isEnabled = true
        
        signUpLabel.isHidden = false
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
        let bottomPadding = (window?.safeAreaInsets.bottom ?? .zero) - signUpButtonBottomConstraint.constant
        
        signUpButtonBottomConstraint.constant = (value - bottomPadding)
        logoImageViewCenterYConstraint.constant = -value
        
        layoutIfNeeded()
    }
    
    func widthdrawTextField() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                /// 50 is the original constraint position
                self.signUpButtonBottomConstraint.constant = self.originalSignUpButtonBottomMargin
                self.logoImageViewCenterYConstraint.constant = .zero
                
                self.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapFemaleButton(_ sender: UIButton) {
        genderSelected = .female
        
        sender.isSelected = true
        maleButton.isSelected = false
        
        maleButton.tintColor = .lightGray
        sender.tintColor = .systemTeal
    }
    
    @IBAction func didTapMaleButton(_ sender: UIButton) {
        genderSelected = .male
        
        sender.isSelected = true
        femaleButton.isSelected = false
        
        femaleButton.tintColor = .lightGray
        sender.tintColor = .systemTeal
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        delegate?.signUpView(self, didTapCancelButton: sender)
    }
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        delegate?.signUpView(self, didTapSignUpButton: sender)
    }
    
}
