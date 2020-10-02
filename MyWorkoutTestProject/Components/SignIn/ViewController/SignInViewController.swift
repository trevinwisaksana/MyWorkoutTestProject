//
//  SignInViewController.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: -
    
    init(email: String) {
        self.viewModel = SignInViewModel(email: email)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    lazy var signInView: SignInView = {
        let nibName = String(describing: SignInView.self)
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! SignInView
        view.delegate = self
        return view
    }()
    
    private let viewModel: SignInViewModel
    private lazy var presenter = SignInPresenter(self)
    
    // MARK: - Application Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view = signInView
        
        viewModel.configure(signInView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        signInView.setupKeyboardListener()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        signInView.removeKeyboardListener()
    }
    
}

// MARK: - SignInViewDelegate

extension SignInViewController: SignInViewDelegate {
    func signInView(_ view: SignInView, didTapCancelButton: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func signInView(_ view: SignInView, didTapSignUpButton: UIButton) {
        view.showLoadingIndicator()
        
        viewModel.viewControllerIsExiting = true
        
        if view.isKeyboardPresented {
            view.resignTextField()
        } else {
            signIn()
        }
    }
    
    func keyboardDidHide(in view: SignInView) {
        if viewModel.viewControllerIsExiting {
            signIn()
        }
    }
    
    private func signIn() {
        viewModel.login(email: signInView.email(), password: signInView.password(), onSuccess: {
            self.signInView.hideLoadingIndicator()
            self.presenter.presentProfileScreen()
        }, onError: { (errorMessage) in
            self.signInView.showError(message: errorMessage)
            self.signInView.hideLoadingIndicator()
        })
    }
}
