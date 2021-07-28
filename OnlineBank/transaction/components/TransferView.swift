//
//  TransferView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 19/07/2021.
//

import SwiftUI

struct TransferView: View {
    
    @State private var transactionSucceed = false
    @State private var transactionMsg = ""
    @State private var amount = ""
    @State private var account = ""
    @State private var recipientAccount = ""
    @State private var accounts = [Account]()
    @State private var transactionRequest = TransactionRequest(userId: "", accountNumber: "", recipientAccountNumber: "", amount: 0.0)
    
    func accountType(value: String) -> String {
        switch value {
        case "ACCOUNT_TYPE_EPARGNE":
            return "Épargne"
        default:
            return "Courant"
        }
    }
    
    func successMessage() -> String {
        
        return "Good news ! Votre transaction a été effectuée avec succès 😄"
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Transfer")
                    .font(.title)
                Spacer()
                Group {
                    if transactionSucceed {
                        Image(systemName: "checkmark.circle.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.green)
                    } else {
                        Button(action: {
                            
                            if(amount != "" || recipientAccount != "" || account != "") {
                                
                                if account != recipientAccount {
                                
                                    transactionRequest.amount = Double(amount)!
                                    transactionRequest.accountNumber = account
                                    transactionRequest.recipientAccountNumber = recipientAccount
                                    
                                    Transfer().execute(request: transactionRequest) { success in
                                        if success {
                                            transactionSucceed = true
                                            return
                                        }
                                        
                                        transactionSucceed = false
                                        transactionMsg = "Transaction failed ! Please try again."
                                    }
                                } else {
                                    transactionMsg = "You cannot transfer amount to the same account"
                                }
                            } else {
                                transactionMsg = "Please fill correctly fields !"
                            }
                            
                        }, label: {
                            Image(systemName: "arrow.up.circle.fill")
                        })
                        .font(.title)
                    }
                }
            }
            .padding()
            
            Group {
                if transactionSucceed {
                    VStack(alignment: .center) {
                        Text(successMessage())
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            
                        Text("").frame(height: 100)
                    }
                    .padding()
                } else {
                    VStack {
                        TextField("Amount", text: self.$amount)
                          .padding()
                          .background(Color.gray.brightness(0.5))
                          .cornerRadius(5.0)
                          .border(Color.black)
                          .keyboardType(.decimalPad)
                        
                        Text("Choose an account")
                        Picker("Accounts", selection: $account) {
                            ForEach(accounts) { account in
                                Text(accountType(value: account.accountType))
                                    .tag(account.accountNumber)
                                    .font(.subheadline)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: UIScreen.main.bounds.width / 1.1, height: 50, alignment: .center)
                        .onAppear() {
                            GetAccountsList().execute() { accounts in
                                self.accounts = accounts
                            }
                        }
                        
                        Text("Choose recepient account")
                        Picker("Accounts", selection: $recipientAccount) {
                            ForEach(accounts) { account in
                                Text(accountType(value: account.accountType))
                                    .tag(account.accountNumber)
                                    .font(.subheadline)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: UIScreen.main.bounds.width / 1.1, height: 50, alignment: .center)
                        .onAppear() {
                            GetAccountsList().execute() { accounts in
                                self.accounts = accounts
                            }
                        }
                        
                        Text("").frame(height: 100)
                    }
                    .padding()
                }
            }
        }
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
