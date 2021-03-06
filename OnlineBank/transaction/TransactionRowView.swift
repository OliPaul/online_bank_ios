//
//  TransactionRowView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 08/07/2021.
//

import SwiftUI

struct TransactionRowView: View {
    
    var transaction: Transaction = Transaction(userId: "userID", accountNumber: "AccountNumber", amount: 200, type: "TRANSACTION_TYPE_PAYMENT", status: "Status", created_at: "Date", updated_at: "date")
    @State private var transactionType = ""
    @State private var amount = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transactionType)
                    .font(.title3)
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
                    .font(.footnote)
                    .fontWeight(.light)
                Text(transaction.accountNumber)
                    .font(.system(size: 10))
                    .fontWeight(.thin)
                
            }
            
            Spacer()
            Text("\(amount) €")
                .foregroundColor(transactionType == "Payment"
                                    ? .green
                                : .red)
        }
        .padding()
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView()
    }
}
