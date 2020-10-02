//
//  SignUpViewController.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    // MARK: -
    
    init(email: String) {
        self.viewModel = SignUpViewModel(email: email)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    lazy var signUpView: SignUpView = {
        let nibName = String(describing: SignUpView.self)
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! SignUpView
        view.delegate = self
        return view
    }()
    
    private let viewModel: SignUpViewModel
    private lazy var presenter = SignUpPresenter(self)
    
    // MARK: - Application Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view = signUpView
        
        viewModel.configure(signUpView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        signUpView.setupKeyboardListener()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        signUpView.removeKeyboardListener()
    }
    
}

// MARK: - SignUpViewDelegate

extension SignUpViewController: SignUpViewDelegate {
    func signUpView(_ view: SignUpView, didTapCancelButton: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func signUpView(_ view: SignUpView, didTapSignUpButton: UIButton) {
        view.showLoadingIndicator()
        
        viewModel.viewControllerIsExiting = true
        
        if view.isKeyboardPresented {
            view.resignTextField()
        } else {
            signUp()
        }
    }
    
    func keyboardDidHide(in view: SignUpView) {
        if viewModel.viewControllerIsExiting {
            signUp()
        }
    }
    
    private func signUp() {
        viewModel.signUp(email: signUpView.email(), password: signUpView.password(), gender: signUpView.genderSelected, onSuccess: {
            self.signUpView.hideLoadingIndicator()
            self.presenter.presentProfileScreen()
        }, onError: { (errorMessage) in
            self.signUpView.showError(message: errorMessage)
            self.signUpView.hideLoadingIndicator()
        })
    }
}
