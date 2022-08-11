//
//  Extendsion.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 23/07/2022.
//

import Foundation
import SwiftUI

extension View {
    
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

extension View {
    func borderedCaption(textColor: Color = .blue) -> some View {
        modifier(BorderedCaption(textColor: textColor))
    }
}

extension View {
    
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}
