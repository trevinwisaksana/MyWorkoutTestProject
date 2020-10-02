//
//  ProfileViewController.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Initializer -
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties -
    
    lazy var profileView: ProfileView = {
        let nibName = String(describing: ProfileView.self)
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! ProfileView
        view.delegate = self
        return view
    }()
    
    private let viewModel = ProfileViewModel()
    private lazy var presenter = ProfilePresenter(self)
    
    // MARK: - Application Lifecycle -
    
    override func loadView() {
        super.loadView()
        
        self.view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserProfile()
    }
    
    private func getUserProfile() {
        viewModel.getUserProfile(onSuccess: {
            self.viewModel.configure(self.profileView)
        }, onError: { (errorMessage) in
            
        })
    }
    
}

// MARK: - ProfileViewDelegate

extension ProfileViewController: ProfileViewDelegate {
    func profileView(_ view: ProfileView, didTapLogOutButton button: UIButton) {
        viewModel.logout(onSuccess: {
            self.presenter.presentWelcomeScreen()
        }, onError: { (errorMessage) in
            
        })
    }
}
