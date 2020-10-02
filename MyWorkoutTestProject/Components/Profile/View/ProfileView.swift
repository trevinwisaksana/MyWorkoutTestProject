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
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setButtonCornerRadius()
        setProfileImageCornerRadius()
    }
    
    private func setButtonCornerRadius() {
        logoutButton.layer.cornerRadius = 8
    }
    
    private func setProfileImageCornerRadius() {
        let height = profileImageView.frame.height / 2
        profileImageView.layer.cornerRadius = height
        profileImageView.clipsToBounds = true
    }
    
    // MARK: - 
    
    @IBAction func didTapLogOutButton(_ sender: UIButton) {
        delegate?.profileView(self, didTapLogOutButton: sender)
    }

}
