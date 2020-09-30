//
//  WelcomeView.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 30/09/20.
//

import UIKit

protocol WelcomeViewDelegate: class {
    func welcomeView(_ view: WelcomeView, didTapNextButton: UIButton)
}

final class WelcomeView: UIView {
    
    // MARK: -
    
    weak var delegate: WelcomeViewDelegate?
    
    // MARK: - IBAction
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        delegate?.welcomeView(self, didTapNextButton: sender)
    }
    
}
