//
//  TransactionRowView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 28/06/2021.
//

import SwiftUI

struct TransactionRowView: View {
    
    var transaction: Transaction
    @State private var transactionType = ""
    @State private var amount = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transactionType)
                    .onAppear() {
                        switch transaction.type {
                        case "TRANSACTION_TYPE_PAYMENT":
                            transactionType = "Payment"
                            amount = "+\(transaction.amount)"
                            break
                        case "TRANSACTION_TYPE_WITHDRAWAL":
                            transactionType = "Withdrawal"
                            amount = "-\(transaction.amount)"
                            break
                        case "TRANSACTION_TYPE_TRANSFER":
                            transactionType = "Transfer"
                            amount = "-\(transaction.amount)"
                            break
                        default:
                            transactionType = ""
                            amount = ""
                        }
                        
                    }
                Text(transaction.created_at.split(separator: "T")[0])
            }
            Spacer()
            Text("\(amount)€")
        }
        .padding()
    }
}
