//
//  Transaction.swift
//  OnlineBank
//
//  Created by Paul Olivier on 28/06/2021.
//

import Foundation

struct Transaction : Codable, Identifiable {
    var id = UUID()
    var userId: String
    var accountNumber: String
    var recipientAccountNumber: String?
    var amount: Double
    var type: String
    var status: String
    var created_at: String
    var updated_at: String
}
