//
//  CustomStyleView.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 23/07/2022.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
        //.brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct CustomStyleView: View {
    var body: some View {
            Button(action: {
                
            }, label: {
                Text("Click Me")
                    .font(.headline)
                    .withDefaultButtonFormatting()
            })
            .withPressableStyle(scaledAmount: 0.9)
            .padding(40)
        }
}

struct CustomStyleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomStyleView()
    }
}
