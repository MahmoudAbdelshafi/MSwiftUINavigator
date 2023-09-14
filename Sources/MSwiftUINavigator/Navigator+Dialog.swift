//
//  Navigator+Dialog.swift
//  MNavigator
//
//  Created by Soliman Elfar and Mahmoud Abdelshafion 01/09/2023.
//  All rights reserved.
//

import SwiftUI

public struct NavigatorCustomDialog<DialogContent: View>: ViewModifier {
    private let dialogContent: () -> DialogContent
    
    public init(
        dialogContent: @escaping () -> DialogContent) {
            self.dialogContent = dialogContent
        }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            Rectangle().foregroundColor(Color.black.opacity(0.6))
            ZStack {
                dialogContent()
            }
            .padding(20)
        }
    }
}

internal extension View {
    func presentAsNavigatorDialog<DialogContent: View>(
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) -> some View {
        modifier(NavigatorCustomDialog(dialogContent: dialogContent))
    }
}
