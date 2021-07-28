//
//  CustomSheetView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 18/07/2021.
//

import SwiftUI

struct CustomSheetView<TransactionTypeView: View>: View {
    
    @Binding var displayed: Bool
    let backgroundColor: Color
    let content: TransactionTypeView
    
    @State var offset = UIScreen.main.bounds.height
    let heightToDisappear = UIScreen.main.bounds.height
    let cellHeight: CGFloat = 25
    
    public init(
            displayed: Binding<Bool>,
            content: TransactionTypeView,
            backgroundColor: Color = Color.white
        ) {
            _displayed = displayed
            self.content = content
            self.backgroundColor = backgroundColor
        }
    
    func hide() {
            offset = heightToDisappear
            displayed = false
        }
            
        var topHalfMiddleBar: some View {
            Capsule()
                .frame(width: 130, height: 5)
                .foregroundColor(Color.gray)
                .padding(.top, 20)
        }
        
        var interactiveGesture: some Gesture {
            DragGesture()
                .onChanged({ (value) in
                    if value.translation.height > 0 {
                        offset = value.location.y
                    }
                })
                .onEnded({ (value) in
                    let diff = abs(offset-value.location.y)
                    if diff > 100 {
                        hide()
                    }
                    else {
                        offset = 0
                    }
                })
        }
        
        var outOfFocusArea: some View {
            Group {
                if displayed {
                    GreyView {
                        self.displayed = false
                    }
                }
            }
        }
        
        var sheetView: some View {
            VStack {
                Spacer()
                
                VStack {
                    topHalfMiddleBar
                    content
                }
                .background(Color.white)
                .cornerRadius(20)
                //.offset(y: offset)
                .gesture(interactiveGesture)
            }
        }
    
    
    var body: some View {
        Group {
            if displayed {
                ZStack {
                    outOfFocusArea
                    sheetView
                }
            }
        }
    }
}

struct CustomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomSheetView(displayed: .constant(true), content: PaymentView())
        }
    }
}
