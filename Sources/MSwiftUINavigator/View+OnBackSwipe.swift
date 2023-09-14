//
//  View+OnBackSwipe.swift
//  MNavigator
//
//  Created by Soliman Elfar and Mahmoud Abdelshafion 01/09/2023.
//  All rights reserved.
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
