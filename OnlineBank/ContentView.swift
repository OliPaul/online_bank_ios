//
//  ContentView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 11/06/2021.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack () {
                Spacer()
                LoginView()
                Spacer()
            }
            .background(Color.blue.brightness(0.25).ignoresSafeArea())
        }
        .navigationBarHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
