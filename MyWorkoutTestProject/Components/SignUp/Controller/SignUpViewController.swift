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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - SignUpViewDelegate

extension SignUpViewController: SignUpViewDelegate {
    func signUpView(_ view: SignUpView, didTapCancelButton: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func signUpView(_ view: SignUpView, didTapSignUpButton: UIButton) {
        guard let email = view.email() else {
            return
        }
        
        guard let password = view.password() else {
            return
        }
        
        guard let genderSelected = view.genderSelected else {
            return
        }
        
        viewModel.signUp(email: email, password: password, gender: genderSelected, onSuccess: {
            self.presenter.presentProfileScreen()
        }, onError: { (errorMessage) in
            
        })
    }
}
