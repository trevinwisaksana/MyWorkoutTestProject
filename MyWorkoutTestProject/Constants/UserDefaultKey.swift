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
    case currentUserEmail = "com.MyWorkoutTestProject.currentUserEmail"
    case appHasBeenLaunchedOnce = "com.MyWorkoutTestProject.appHasBeenLaunchedOnce"
    
    var value: String {
        return rawValue
    }
}
