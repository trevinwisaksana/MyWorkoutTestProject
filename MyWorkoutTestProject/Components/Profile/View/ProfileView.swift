//
//  ProfileView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import UIKit

final class ProfileView: UIView {
    
    // MARK: -
    
    @IBOutlet weak var logoutButton: UIButton!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setButtonCornerRadius()
    }
    
    private func setButtonCornerRadius() {
        logoutButton.layer.cornerRadius = 8
    }
    
    // MARK: - 
    
    @IBAction func didTapLogOutButton(_ sender: UIButton) {
        
    }

}
