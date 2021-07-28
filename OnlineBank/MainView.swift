//
//  DashboardView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 26/06/2021.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = 1
    @State private var actionSheetDisplayed = false
    @State private var transactionSheetDisplayed = false
    @State private var transactionType = ""
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                TransactionView()
                    .tabItem {
                        Label("Transactions", systemImage: "arrow.left.arrow.right")
                    }
                    .tag(0)
                DashboardView(selectedTab: $selectedTab)
                    .tabItem {
                        Label("Dashboard", systemImage: "wallet.pass.fill")
                    }
                    .tag(1)
                RatesView()
                    .tabItem {
                        Label("Exchange rate", systemImage: "arrow.down.right.and.arrow.up.left.circle.fill")
                    }
                    .tag(2)
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Online Bank")
            .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button(action: {
                            actionSheetDisplayed.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    })
            })
            .actionSheet(isPresented: $actionSheetDisplayed, content: {
                ActionSheet(title: Text("New transaction"), message: nil, buttons: [
                                .default(Text("Payment")) {
                                    self.transactionType = "payment"
                                    self.transactionSheetDisplayed.toggle()
                                },
                                .default(Text("Withdrawal")) {
                                    self.transactionType = "withdrawal"
                                    self.transactionSheetDisplayed.toggle()
                                },
                                .default(Text("Transfer")) {
                                    self.transactionType = "transfer"
                                    self.transactionSheetDisplayed.toggle()
                                },
                                .cancel()])
            })
            
            CustomSheetView(displayed: $transactionSheetDisplayed, content: Group {
                if transactionType == "payment" {
                    PaymentView()
                } else if transactionType == "withdrawal" {
                    WithdrawalView()
                } else if transactionType == "transfer" {
                    TransferView()
                }
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
