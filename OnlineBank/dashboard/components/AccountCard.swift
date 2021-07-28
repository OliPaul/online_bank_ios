//
//  AccountCard.swift
//  OnlineBank
//
//  Created by Paul Olivier on 07/07/2021.
//

import SwiftUI

struct AccountCard: View {
    
    var account: Account = Account(id: UUID(), userId: "4dee9fc6-317b-41d4-8ff1-998dc4711cd3", accountNumber: "OB-bed56c01-5484-4979-b531-b1f4a64b4534", accountType: "ACCOUNT_TYPE_EPARGNE", accountBalance: 1200.00, accountStatus: "ACCOUNT_STATUS_PENDING", created_at: "2021-07-07T09:34:17", updated_at: "2021-07-07T09:34:17")
    
    func accountType(value: String) -> String {
        switch value {
        case "ACCOUNT_TYPE_EPARGNE":
            return "Épargne"
        default:
            return "Courant"
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(accountType(value: account.accountType))
                        .font(.title2)
                    Spacer()
                    Text("\(String(format: "%.2f", account.accountBalance)) €")
                        .font(.title2)
                }
                .padding([.top, .horizontal])
                
            }
            Text(account.accountNumber)
                .font(.footnote)
                .italic()
                .fontWeight(.thin)
                .padding([.vertical])
            
        }
        .background(account.accountType == "ACCOUNT_TYPE_COURANT" ? Color.blue.brightness(0.3) : Color.gray.brightness(0.4))
        .cornerRadius(5.0)
        .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                )
        .padding([.bottom, .horizontal])
    }
}

struct AccountCard_Previews: PreviewProvider {
    static var previews: some View {
        AccountCard()
    }
}
