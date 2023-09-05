//
//  MSwiftUINavigatorExampleApp.swift
//  MSwiftUINavigatorExample
//
//  Created by Mahmoud Abdelshafi on 05/09/2023.
//

import SwiftUI

@main
struct MSwiftUINavigatorExampleApp: App {
    @Environment(\.navigator) var navigator
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainScreen()
            }
        }
    }
}
