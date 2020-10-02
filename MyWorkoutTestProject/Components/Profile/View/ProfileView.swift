//
//  ProfileView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

protocol ProfileViewDelegate: class {
    func profileView(_ view: ProfileView, didTapLogOutButton button: UIButton)
}

final class ProfileView: UIView {
    
    // MARK: -
    
    weak var delegate: ProfileViewDelegate?
    
    // MARK: -
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    
    private let logoutTitle = "Log out"
    
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
        
        clearText()
        setButtonCornerRadius()
        setProfileImageCornerRadius()
    }
    
    private func clearText() {
        emailLabel.text = ""
        genderLabel.text = ""
    }
    
    private func setButtonCornerRadius() {
        logoutButton.layer.cornerRadius = 8
    }
    
    private func setProfileImageCornerRadius() {
        let height = profileImageView.frame.height / 2
        profileImageView.layer.cornerRadius = height
        profileImageView.clipsToBounds = true
    }
    
    func showLoadingIndicator() {
        logoutButton.isEnabled = false
        logoutButton.setTitle("", for: .normal)
        
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: logoutButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor)
        ])
    }
    
    func hideLoadingIndicator() {
        logoutButton.isEnabled = true
        logoutButton.setTitle(logoutTitle, for: .normal)
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func showError(message: String) {
        toastView.show(withMessage: message, at: .top)
    }
    
    // MARK: - 
    
    @IBAction func didTapLogOutButton(_ sender: UIButton) {
        delegate?.profileView(self, didTapLogOutButton: sender)
    }

}
