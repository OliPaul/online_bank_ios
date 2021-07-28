//
//  PaymentRequest.swift
//  OnlineBank
//
//  Created by Paul Olivier on 19/07/2021.
//

import Foundation

struct TransactionRequest: Codable {
    
    var userId: String
    var accountNumber: String
    var recipientAccountNumber: String
    var amount: Double
}
