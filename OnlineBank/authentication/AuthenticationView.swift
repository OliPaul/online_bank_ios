//
//  AuthenticationView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 11/06/2021.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var loginRequest = LoginRequest(email: "", password: "")
    @ObservedObject var login = Login()
    
    var body: some View {
        VStack() {
            AppTitle()
            AuthIcon()
            AuthFieldsComponent(email: self.$email, password: self.$password)

            Button("Sign In") {
                loginRequest.email = email
                loginRequest.password = password
                
                login.execute(request: loginRequest)
                
            }
            .padding()
            .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10.0)
            .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 2, x: 2.0, y: 2.0)
            
            
          }
        .padding()
        
    }
}

/*struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}*/

struct AppTitle: View {
    var body: some View {
        Text("Online Bank")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 18)
    }
}

