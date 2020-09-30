//
//  SignUpViewController.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var signUpView: SignUpView = {
        let nibName = String(describing: SignUpView.self)
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! SignUpView
        return view
    }()
    
    private let viewModel = SignUpViewModel()
    
    // MARK: - Application Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
