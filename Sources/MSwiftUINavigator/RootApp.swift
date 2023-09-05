//
//  RootApp.swift
//  MNavigator
//
//  Created by Mahmoud Abdelshafi on 01/09/2023.
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
