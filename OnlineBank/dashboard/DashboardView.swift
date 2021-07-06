//
//  DashboardView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var transactions = [Transaction]()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Compte courant")
                Spacer()
                Text("1500€")
            }
            .padding()
            .background(Color.blue.brightness(0.4))
            .cornerRadius(5.0)
            HStack {
                Text("Compte épargne")
                Spacer()
                Text("100 000€")
            }
            .padding()
            .background(Color.blue.brightness(0.4))
            .cornerRadius(5.0)
            Spacer()
            Text("Last transaction")
            List(transactions) { transaction in
                TransactionRowView(transaction: transaction)
            }
            .onAppear() {
                GetTransactionsList().execute() { transactions in
                    
                    self.transactions = transactions
                }
            }
            
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
