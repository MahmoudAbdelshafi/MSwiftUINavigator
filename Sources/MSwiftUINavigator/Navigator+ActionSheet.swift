//
//  Navigator+ActionSheet.swift
//  MNavigator
//
//  Created by Soliman Elfar and Mahmoud Abdelshafion 01/09/2023.
//  All rights reserved.
//

import SwiftUI

public struct NavigatorCustomActionSheet: ViewModifier {
    private let actionSheetContent: () -> ActionSheet
    @State private var showActionSheet = true
    
    public init(
        actionSheetContent: @escaping () -> ActionSheet) {
            self.actionSheetContent = actionSheetContent
        }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            Rectangle().foregroundColor(Color.black.opacity(0.6))
        }.actionSheet(isPresented: $showActionSheet) {
            actionSheetContent()
        }
    }
}

internal extension View {
    func presentAsNavigatorActionSheet(
        @ViewBuilder actionSheetContent: @escaping () -> ActionSheet
    ) -> some View {
        modifier(NavigatorCustomActionSheet(actionSheetContent: actionSheetContent))
    }
}

