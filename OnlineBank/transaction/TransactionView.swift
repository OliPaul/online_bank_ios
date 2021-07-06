//
//  TransactionView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import SwiftUI

struct TransactionView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Transactions")
            }
        }
        .toolbar(content: {
            ToolbarItemGroup {
            Button(action: {}, label: {
                Image(systemName: "plus")
            })
            }
        })
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
