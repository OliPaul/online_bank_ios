//
//  AuthenticationView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 11/06/2021.
//

import SwiftUI

struct LoginView: View {
    
    @State private var isAuthenticated = false
    @State private var email = ""
    @State private var password = ""
    @State private var loginRequest = LoginRequest(email: "", password: "")
    @State private var errors = [
        "email": false,
        "password": false,
        "message": ""
    ]
    
    var body: some View {
        
        VStack {
            AppTitle()
            AuthIcon()
            Text(errors["message"] as! String)
                .foregroundColor(.red)
            AuthFieldsComponent(email: self.$email, password: self.$password, errors: self.$errors)

            NavigationLink(destination: MainView(), isActive: $isAuthenticated) {
                Button("Sign In") {
                    
                    errors = [
                        "email": false,
                        "password": false,
                        "message": ""
                    ]
                    
                    if !email.isValidEmail || email == "" {
                        errors["email"] = true
                        errors["message"] = "Please enter a valid email address"
                        return
                    }
                    
                    if password == "" {
                        errors["password"] = true
                        errors["message"] = "Please fill password field"
                        return
                    }
                    
                    
                    loginRequest.email = email
                    loginRequest.password = password
                    
                    Login().execute(request: loginRequest) { (authenticated) in
                        
                        if !authenticated {
                            errors["message"] = "Invalid credentials"
                            return
                        }
                        
                        self.isAuthenticated = authenticated
                    }
                    
                }
                .padding()
                .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 2, x: 2.0, y: 2.0)
                .padding(.bottom)
            }
            
            NavigationLink(destination: RegisterView()) {
                Text("Create an account") 
                .foregroundColor(.white)
            }
            
        }
        .padding()
    }
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

