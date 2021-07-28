//
//  TransactionCardView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 28/06/2021.
//

import SwiftUI

struct TransactionCardView: View {
    
    var transaction: Transaction = Transaction(userId: "userID", accountNumber: "AccountNumber", amount: 200, type: "TRANSACTION_TYPE_PAYMENT", status: "Status", created_at: "Date", updated_at: "date")
    @State private var transactionType = ""
    @State private var amount = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(transaction.created_at.split(separator: "T")[0])
                    .font(.footnote)
                    .fontWeight(.thin)
            }
            VStack {
                Text("\(amount) €")
                    .font(.title3)
                    .bold()
                Text(transactionType)
                    .font(.title3)
                    .fontWeight(.light)
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
                
            }
            
        }
        .frame(width: 100, height: 100, alignment: .leading)
        .padding([.horizontal])
        .background(transaction.type == "TRANSACTION_TYPE_PAYMENT" ? Color.green.brightness(0.1) : Color.red.brightness(0.1))
        .cornerRadius(10.0)
        .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                )
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCardView()
    }
}
