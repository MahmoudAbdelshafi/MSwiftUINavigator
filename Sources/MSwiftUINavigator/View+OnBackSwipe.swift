//
//  View+OnBackSwipe.swift
//  MNavigator
//
//  Created by Mahmoud Abdelshafi on 01/09/2023.
//

import SwiftUI

public extension View {
    
    func onBackSwipe(perform action: @escaping () -> Void) -> some View {
        gesture(
            DragGesture()
                .onEnded({ value in
                    if value.startLocation.x <  50 && value.translation.width >  80 {
                        action()
                    }
                })
        )
    }
    
}
