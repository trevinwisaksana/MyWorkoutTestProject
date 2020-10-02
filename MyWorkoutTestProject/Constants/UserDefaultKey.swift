//
//  UserDefaultKey.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

enum UserDefaultKey: String {
    case isUserLoggedIn = "com.MyWorkoutTestProject.isUserLoggedIn"
    
    var value: String {
        return rawValue
    }
}
