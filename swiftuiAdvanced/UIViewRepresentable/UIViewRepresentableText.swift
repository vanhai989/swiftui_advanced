//
//  UIViewRepresentableText.swift
//  swiftuiAdvanced
//
//  Created by hai dev on 08/08/2022.
//

import SwiftUI

struct UIViewRepresentableText: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            UITextRepresentable()
                .frame(width: 200, height: 50, alignment: .center)
            
            UIImageRepresentable()
            
        }
       
    }
}

struct UIViewRepresentableText_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableText()
    }
}


// convert Text from UIKit to SwiftUI
struct UITextRepresentable: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    
    func makeUIView(context: Context) -> some UITextView {
        return getUIText()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.textColor = UIColor(.blue)
    }
    
        private func getUIText() -> UITextView {
            let textView = UITextView()
            textView.text = "hello I'm Hai dev"
            textView.textColor = UIColor(.green)
            textView.backgroundColor = UIColor(.red)
            return textView
        }

    class Coordinator: NSObject, UITextViewDelegate {
    }
    
}

// convert Image from UIKit to SwiftUI

struct UIImageRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.tintColor = UIColor(.red)
    }
    

    func makeUIView(context: Context) -> UIImageView {
        let uiImageView = UIImageView()
        uiImageView.image = UIImage(systemName: "heart")
        return uiImageView
    }

}

