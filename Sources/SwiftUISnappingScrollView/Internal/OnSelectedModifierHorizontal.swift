//
//  File.swift
//  
//
//  Created by Robin Franke on 27.06.24.
//

import SwiftUI

internal struct OnSelectedModifierHorizontal: ViewModifier {
    @Environment(\.scrollViewFrame) private var scrollViewFrame
    @State private var isSelected: Bool? = nil
    
    var action: (Bool) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    let isSelected = abs((scrollViewFrame?.midX ?? 0) - geometry.frame(in: .global).midX) < 240

                    Color.clear
                        .onAppear { onSelectedHorizontal(isSelected) }
                        .onUpdate(of: isSelected, perform: onSelectedHorizontal)
                }
                .hidden()
            )
    }
    
    private func onSelectedHorizontal(_ newValue: Bool?) {
        if let newValue = newValue, isSelected != newValue {
            isSelected = newValue
            action(newValue)
        }
    }
}
