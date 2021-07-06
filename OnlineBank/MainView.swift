//
//  DashboardView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 26/06/2021.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AccountView()
                .tabItem {
                    Label("Accounts", systemImage: "rectangle.stack.fill.badge.person.crop")
                }
                .tag(0)
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "wallet.pass.fill")
                }
                .tag(1)
            TransactionView()
                .tabItem {
                    Label("Transactions", systemImage: "arrow.left.arrow.right")
                }
                .tag(2)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Online Bank")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
