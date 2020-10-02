//
//  Gender.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 01/10/20.
//

import Foundation

enum Gender: String {
    case male
    case female
    
    var title: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}
