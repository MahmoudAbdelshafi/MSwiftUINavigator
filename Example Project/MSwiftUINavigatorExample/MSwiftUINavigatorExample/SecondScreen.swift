//
//  SecondScreen.swift
//  MSwiftUINavigatorExample
//
//  Created by Mahmoud Abdelshafi on 06/09/2023.
//

import SwiftUI

struct SecondScreen: View {
    
    @Environment(\.navigator) var navigator
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Second Screen")
                .fontWeight(.heavy)
                .foregroundColor(.green)
            
            Button("Dismiss") {
                navigator.dismiss()
            }
            .bold()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
    }
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen()
    }
}
