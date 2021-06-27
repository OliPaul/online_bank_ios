//
//  ViewExt.swift
//  OnlineBank
//
//  Created by Paul Olivier on 24/06/2021.
//
import Foundation
import SwiftUI

extension View {
        /**
         Returns a view that is visible or not visible based on `isVisible`.
         */
        func visible(_ isVisible: Bool) -> some View {
            modifier(VisibleModifier(isVisible: isVisible))
        }
}

fileprivate struct VisibleModifier: ViewModifier {
    let isVisible: Bool

    func body(content: Content) -> some View {
        Group {
            if isVisible {
                content
            } else {
                EmptyView()
            }
        }
    }
}
