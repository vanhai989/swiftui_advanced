//
//  ModifierView.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 23/07/2022.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

struct BorderedCaption: ViewModifier {
    var textColor: Color
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
            )
            .foregroundColor(textColor)
    }
}

struct ModifierView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .borderedCaption(textColor: .red)
            Text("Hello, World!")
                .borderedCaption(textColor: .green)
            Text("Hello, World!")
                .borderedCaption()
        }
    }
}

struct ModifierView_Previews: PreviewProvider {
    static var previews: some View {
        ModifierView()
    }
}
