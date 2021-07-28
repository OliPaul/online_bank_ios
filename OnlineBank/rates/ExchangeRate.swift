//
//  ExchangeRate.swift
//  OnlineBank
//
//  Created by Paul Olivier on 07/07/2021.
//

import Foundation

struct ExchangeRate : Codable {
    var date: String
    var success: Bool
    var rates: Rates
    var base: String
    
}
