//
//  UserDefaultKey.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

enum UserDefaultKey: String {
    case isUserLoggedIn = "com.MyWorkoutTestProject.isUserLoggedIn"
    case userData = "com.MyWorkoutTestProject.userData"
    
    var value: String {
        return rawValue
    }
}
