//
//  RegisterRequest.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import Foundation

struct RegisterRequest: Codable {
    
    var firstname: String
    var lastname: String
    var phone: String
    var email: String
    var password: String
    
}
