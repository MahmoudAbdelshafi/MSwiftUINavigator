//
//  RootApp.swift
//  MNavigator
//
//  Created by Soliman Elfar and Mahmoud Abdelshafion 01/09/2023.
//  All rights reserved.
//

import SwiftUI

public struct RootApp<V: View>: View {
    
    private let view: V
    
    public init(view: V) {
        self.view = view
    }
    
    public var body: some View {
        view
    }
    
}
