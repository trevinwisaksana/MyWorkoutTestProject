//
//  WelcomeViewController.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var welcomeView: WelcomeView = {
        let nibName = String(describing: WelcomeView.self)
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! WelcomeView
        view.delegate = self
        return view
    }()
    
    private let viewModel = WelcomeViewModel()
    private lazy var presenter = WelcomePresenter(self)
    
    // MARK: - Application Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view = welcomeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        welcomeView.setupKeyboardListener()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        welcomeView.removeKeyboardListener()
    }

}

// MARK: - WelcomeViewDelegate

extension WelcomeViewController: WelcomeViewDelegate {
    func welcomeView(_ view: WelcomeView, didTapNextButton: UIButton) {
        view.showLoadingIndicator()
        
        viewModel.viewControllerIsExiting = true
        
        if view.isKeyboardPresented {
            view.resignTextField()
        } else {
            verifyUser()
        }
    }
    
    func keyboardDidHide(in view: WelcomeView) {
        if viewModel.viewControllerIsExiting {
            verifyUser()
        }
    }
    
    private func verifyUser() {
        guard let email = welcomeView.email(), !email.isEmpty else {
            welcomeView.showError(message: "Please enter a valid email.")
            welcomeView.enableNextButton()
            return
        }
        
        viewModel.verify(email: email, onSuccess: { (isVerified) in
            
            self.welcomeView.hideLoadingIndicator()
            
            if isVerified {
                self.presenter.presentWelcomeBackScreen(withEmail: email)
            } else {
                self.presenter.presentSignUpScreen(withEmail: email)
            }
            
        }, onError: { (errorMessage) in
            self.welcomeView.showError(message: errorMessage)
            self.welcomeView.hideLoadingIndicator()
        })
    }
}
