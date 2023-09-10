//
//  ContentView.swift
//  MSwiftUINavigatorExample
//
//  Created by Mahmoud Abdelshafi on 05/09/2023.
//

import SwiftUI
import MSwiftUINavigator

struct MainScreen: View {
    
    @Environment(\.navigator) var navigator
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Push View") {
                navigator.pushView {
                    SecondScreen()
                }
            }
            .bold()
            
            Button("Pesent View") {
                navigator.presentView(presentStyle: .overFullScreen) {
                    NavigationView {
                        SecondScreen()
                    }
                }
            }
            .bold()
            
            Button("Pesent Fittet Sheet") {
                navigator.presentSheet(sizes: [.percent(0.3), .fixed(600)]) {
                    SecondScreen()
                }
            }
            .bold()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
