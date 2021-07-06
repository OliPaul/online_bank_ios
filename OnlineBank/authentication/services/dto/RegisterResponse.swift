//
//  RegisterResponse.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import Foundation

struct RegisterResponse: Codable, Identifiable {
    
    var id: UUID
    var message: String
    
}
