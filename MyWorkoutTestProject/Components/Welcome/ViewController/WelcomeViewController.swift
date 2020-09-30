//
//  WelcomeViewController.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: -
    
    lazy var welcomeView: WelcomeView = {
        let nibName = String(describing: WelcomeView.self)
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as! WelcomeView
        return view
    }()
    
    // MARK: - Application Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view = welcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
