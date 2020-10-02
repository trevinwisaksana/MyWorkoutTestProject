//
//  RegistrationAPIService.swift
//  MyWorkoutTestProject
//
//  Created by Trevin Wisaksana on 02/10/20.
//

import Foundation

final class RegistrationAPIService {
    
    private let dummyDatabase = DummyDatabase()
   
    func register(email: String, password: String, gender: Gender, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        let parameters: [String : String] = ["email": email, "password": password, "gender": gender.rawValue]
        dummyDatabase.registerUser(data: parameters, onSuccess: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                onSuccess()
            }
        }, onError: { (errorMessage) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                onError("Email has already been registered.")
            }
        })
    }
    
}
