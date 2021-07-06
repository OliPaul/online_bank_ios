//
//  RegisterFieldsView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import SwiftUI

struct RegisterFieldsView: View {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var phone: String
    @Binding var email: String
    @Binding var password: String
    @Binding var errors: [String: Any]
    
    var body: some View {
        VStack {
            
            TextField("Firstname", text: self.$firstName)
              .padding()
              .background(Color.gray.brightness(0.4))
              .cornerRadius(5.0)
              .border(errors["firstName"] as! Bool ? Color.red : Color.clear)
              .padding(.bottom, 20)
              .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
              .onChange(of: self.firstName, perform: { value in
                  errors["firstName"] = false
                  errors["message"] = ""
              })
            
            TextField("Lastname", text: self.$lastName)
              .padding()
              .background(Color.gray.brightness(0.4))
              .cornerRadius(5.0)
              .border(errors["lastName"] as! Bool ? Color.red : Color.clear)
              .padding(.bottom, 20)
              .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
              .onChange(of: self.lastName, perform: { value in
                  errors["lastName"] = false
                  errors["message"] = ""
              })
            
            TextField("Phone", text: self.$phone)
              .padding()
              .background(Color.gray.brightness(0.4))
              .cornerRadius(5.0)
              .border(errors["phone"] as! Bool ? Color.red : Color.clear)
              .padding(.bottom, 20)
              .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
              .keyboardType(.phonePad)
              .onChange(of: self.phone, perform: { value in
                  errors["phone"] = false
                  errors["message"] = ""
              })
            AuthFieldsComponent(email: self.$email, password: self.$password, errors: self.$errors)
        }
        
    }
}
