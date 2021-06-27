//
//  AuthFieldsComponent.swift
//  OnlineBank
//
//  Created by Paul Olivier on 22/06/2021.
//

import SwiftUI

struct AuthFieldsComponent: View {
    
    @Binding var email : String
    @Binding var password : String
    @Binding var errors: [String: Any]
    
    var body: some View {
        VStack {
          
          TextField("Email", text: self.$email)
            .padding()
            .background(Color.gray.brightness(0.4))
            .cornerRadius(5.0)
            .border(errors["email"] as! Bool ? Color.red : Color.clear)
            .padding(.bottom, 20)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .onChange(of: self.email, perform: { value in
                errors["email"] = false
                errors["message"] = ""
            })
                        
          SecureField("Password", text: self.$password)
            .padding()
            .background(Color.gray.brightness(0.4))
            .cornerRadius(5.0)
            .border(errors["password"] as! Bool ? Color.red : Color.clear)
            .padding(.bottom, 20)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .onChange(of: self.password, perform: { value in
                errors["password"] = false
                errors["message"] = ""
            })
        }
    }
}

