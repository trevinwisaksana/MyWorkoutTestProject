//
//  WelcomeView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import UIKit

protocol WelcomeViewDelegate: class {
    func welcomeView(_ view: WelcomeView, didTapNextButton: UIButton)
    func keyboardDidHide(in view: WelcomeView)
}

final class WelcomeView: UIView {
    
    // MARK: -
    
    weak var delegate: WelcomeViewDelegate?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var nextIconImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageViewCenterYConstraint: NSLayoutConstraint!
    
    private let originalNextButtonBottomMargin: CGFloat = 50
    
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
        
        emailTextField.delegate = self
        
        addTextFieldPadding()
    }
    
    private func addTextFieldPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
    }
    
    func email() -> String? {
        return emailTextField.text
    }
    
    func showLoadingIndicator() {
        nextButton.isEnabled = false
        nextLabel.isHidden = true
        nextIconImageView.isHidden = true
        
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor)
        ])
    }
    
    func hideLoadingIndicator() {
        nextButton.isEnabled = true
        nextLabel.isHidden = false
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
        let window = UIApplication.shared.windows.first
        let bottomPadding = (window?.safeAreaInsets.bottom ?? .zero) - nextButtonBottomConstraint.constant
        
        nextButtonBottomConstraint.constant = (value - bottomPadding)
        logoImageViewCenterYConstraint.constant = -value
        
        layoutIfNeeded()
    }
    
    func widthdrawTextField() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                /// 50 is the original constraint position
                self.nextButtonBottomConstraint.constant = self.originalNextButtonBottomMargin
                self.logoImageViewCenterYConstraint.constant = .zero
                
                self.layoutIfNeeded()
            })
        }
    }
    
    func resignTextField() {
        emailTextField.resignFirstResponder()
    }
    
    func showError(message: String) {
        toastView.show(withMessage: message, at: .top)
    }
    
    func disableNextButton() {
        nextButton.isEnabled = false
    }
    
    func enableNextButton() {
        nextButton.isEnabled = true
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        delegate?.welcomeView(self, didTapNextButton: sender)
    }
    
}

// MARK: - UITextFieldDelegate

extension WelcomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
