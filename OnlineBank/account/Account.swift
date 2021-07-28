//
//  Account.swift
//  OnlineBank
//
//  Created by Paul Olivier on 07/07/2021.
//

import Foundation

struct Account : Codable, Identifiable {
    var id = UUID()
    var userId: String
    var accountNumber: String
    var accountType: String
    var accountBalance: Double
    var accountStatus: String
    var created_at: String
    var updated_at: String
}
