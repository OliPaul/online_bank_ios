//
//  GreyView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 18/07/2021.
//

import SwiftUI

struct GreyView: View {
    
    let callback: (() -> ())?
    
    public init(
            callback: (() -> ())? = nil
        ) {
            self.callback = callback
        }
    
    var body: some View {
        Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .background(Color.gray)
                    .opacity(0.7)
                    .onTapGesture {
                        callback?()
                    }
                    .ignoresSafeArea()
    }
}

struct GreyView_Previews: PreviewProvider {
    static var previews: some View {
        GreyView()
    }
}
