//
//  UserProfile.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

struct UserProfile {
    var email: String
    var gender: Gender
    
    init?(data: [String : String]) {
        guard let email = data["email"] else {
            return nil
        }
        
        self.email = email
        
        guard let genderValue = data["gender"] else {
            return nil
        }
        
        guard let gender = Gender(rawValue: genderValue) else {
            return nil
        }
        
        self.gender = gender
    }
}
