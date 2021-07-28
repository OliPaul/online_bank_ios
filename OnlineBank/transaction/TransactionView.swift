//
//  TransactionView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import SwiftUI

struct TransactionView: View {
    
    @State private var transactions = [Transaction]()
    
    var body: some View {
        VStack {
            List(transactions) { transaction in
                TransactionRowView(transaction: transaction)
            }
            .onAppear() {
                GetTransactionsList().execute() { transactions in
                    let transactionListReversed = transactions.reversed()
                    let transactionList = Array(transactionListReversed)
                    
                    self.transactions = transactionList
                }
            }
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
