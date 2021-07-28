//
//  WithdrawalView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 19/07/2021.
//

import SwiftUI

struct WithdrawalView: View {
    
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
            motivation = "Bon... je te l'accorde ! Faut bien se faire plaisir et un petit \(currentAmount) € ça fait pas de mal 😄"
        } else if currentAmount.isLessThanOrEqualTo(5000) {
            motivation = "Yo, assure toi que ce que tu vas faire avec ce argent est vraiment utile. C'est une sortie conséquente dans ton budget là ! 😤​"
        }  else {
            motivation = "Hein !? What ? Je ne sais pas pourquoi tu fais ce retrait mais je suis hyper en colère là 😡​"
        }
        
        return motivation
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Withdrawal")
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
                                
                                Withdraw().execute(request: transactionRequest) { success in
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
                            Image(systemName: "arrow.down.circle.fill")
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

struct WithdrawalView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawalView()
    }
}
