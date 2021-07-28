//
//  PaymentView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 08/07/2021.
//

import SwiftUI

struct PaymentView: View {
    
    @State private var transactionSucceed = false;
    @State private var transactionMsg = ""
    @State private var amount = ""
    @State private var account = ""
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
    
    func generateMemes() -> String {
        
        let currentAmount = Double(amount)!
        var motivation = ""
        
        if currentAmount.isLessThanOrEqualTo(250) {
            motivation = "Faineant !!! Bosse beaucoup plus ​😤​😡​🔥​"
        } else if currentAmount.isLessThanOrEqualTo(1000) {
            motivation = "Bien joué ! Si tu verses ce montant par semaine, tu auras \(currentAmount * 4) € par mois 😄"
        } else if currentAmount.isLessThanOrEqualTo(10000) {
            motivation = "Tu devrais songer à investir dans tes projets et préparer ton avenir 😊"
        } else {
            motivation = "Tu es une légende ! Tu peux découvrir d'autres univers comme l'espace 👨‍🚀🚀🌑"
        }
        
        return motivation
        
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            HStack {
                Text("New payment")
                    .font(.title)
                Spacer()
                Group {
                    if transactionSucceed {
                        Image(systemName: "checkmark.circle.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.green)
                    } else {
                        Button(action: {
                            
                            if(amount != "" || account != "") {
                                
                                transactionRequest.amount = Double(amount)!
                                transactionRequest.accountNumber = account
                                
                                Pay().execute(request: transactionRequest) { success in
                                    if success {
                                        transactionSucceed = true
                                        return
                                    }
                                    
                                    transactionSucceed = false
                                    transactionMsg = "Transaction failed ! Please try again."
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
                        Text(generateMemes())
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            
                        Text("").frame(height: 100)
                    }
                    .padding()
                } else {
                    VStack {
                        Text(transactionMsg)
                            .font(.caption)
                            .foregroundColor(.red)
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
                        
                        Text("").frame(height: 100)
                    }
                    .padding()
                }
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
