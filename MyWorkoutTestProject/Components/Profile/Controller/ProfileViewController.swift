//
//  ProfileViewController.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: -
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    lazy var profileView: ProfileView = {
        let nibName = String(describing: ProfileView.self)
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! ProfileView
        return view
    }()
    
    // MARK: - Application Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
