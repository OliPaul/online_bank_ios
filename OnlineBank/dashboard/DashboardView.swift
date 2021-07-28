//
//  DashboardView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var transactions = [Transaction]()
    @State private var accounts = [Account]()
    @Binding var selectedTab: Int

    
    var body: some View {
        VStack(alignment: .leading) {
            VStack  {
                ForEach(accounts) { account in
                    AccountCard(account: account)
                }
                
            }
            .onAppear() {
                GetAccountsList().execute() { accounts in
                    self.accounts = accounts
                }
            }
            HStack {
                Text("Last transactions")
                    .font(.title)
                Spacer()
                Button("more") {
                    self.selectedTab = 0
                }
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(transactions) { transaction in
                        TransactionCardView(transaction: transaction)
                    }
                    
                }
                .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                        )
                .padding([.bottom, .horizontal])
                .onAppear() {
                    GetTransactionsList().execute() { transactions in
                        let transactionListReversed = transactions.reversed()
                        let transactionList = Array(transactionListReversed)
                        
                        if transactionList.count > 5 {
                            self.transactions = Array(transactionList[..<5])
                        }else {
                            self.transactions = transactionList
                        }
                    }
                }
            }
        }
    }
}
