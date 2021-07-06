//
//  RegisterView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var registered = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    @State private var registerRequest = RegisterRequest(
        firstname: "",
        lastname: "",
        phone: "",
        email: "",
        password: ""
    )
    @State private var errors = [
        "firstName": false,
        "lastName": false,
        "phone": false,
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
            RegisterFieldsView(firstName: self.$firstName, lastName: self.$lastName, phone: self.$phone, email: self.$email, password: self.$password, errors: self.$errors)
            NavigationLink(destination: ContentView(), isActive: $registered) {
                Button("Sign Up") {
                    
                    errors = [
                        "firstName": false,
                        "lastName": false,
                        "phone": false,
                        "email": false,
                        "password": false,
                        "message": ""
                    ]
                    
                    if firstName == "" {
                        errors["firstName"] = true
                        errors["message"] = "Please enter your firstname"
                        return
                    }
                    
                    if lastName == "" {
                        errors["lastName"] = true
                        errors["message"] = "Please enter your lastName"
                        return
                    }
                    
                    if phone == "" {
                        errors["phone"] = true
                        errors["message"] = "Please enter your phone number"
                        return
                    }
                    
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
                    
                    registerRequest.firstname = firstName
                    registerRequest.lastname = lastName
                    registerRequest.phone = phone
                    registerRequest.email = email
                    registerRequest.password = password
                    
                    Register().execute(request: registerRequest) { (registered) in
                        
                        if !registered {
                            errors["message"] = "This user already exist"
                            return
                        }
                        
                        self.registered = registered
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
            
            NavigationLink(destination: ContentView()) {
                Text("Already an account ?") 
                .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.blue.brightness(0.25).ignoresSafeArea())
        .navigationBarHidden(true)
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
