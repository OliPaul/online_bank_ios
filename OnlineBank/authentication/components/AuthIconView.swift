//
//  AuthIconView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 23/06/2021.
//

import SwiftUI

struct AuthIcon: View {
    var body: some View {
        Image(systemName: "person.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100, alignment: .center)
            .foregroundColor(Color.gray)
            .background(Color.gray.brightness(0.4))
            .cornerRadius(150.0)
            .padding(.bottom)
    }
}
