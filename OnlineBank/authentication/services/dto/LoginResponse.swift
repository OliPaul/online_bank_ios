//
//  LoginResponse.swift
//  OnlineBank
//
//  Created by Paul Olivier on 23/06/2021.
//

import Foundation

struct LoginResponse: Codable, Identifiable {
    
    var id: UUID
    var firstname: String
    var lastname: String
    var phone: String
    var email: String
    var token: String
    
}
