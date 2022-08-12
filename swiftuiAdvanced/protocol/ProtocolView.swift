//
//  ProtocolView.swift
//  swiftuiAdvanced
//
//  Created by hai dev on 20/07/2022.
//

import SwiftUI

protocol themeColorProtocol {
    var red: Color { get }
    var yellow: Color { get }
    var green: Color { get }
}

struct ColorOne: themeColorProtocol {
    var red: Color = .red
    var yellow: Color = .yellow
    var green: Color = .green
    
}


protocol BaseFuncProtocol {
    func getColor() -> Color
}

struct ImplementBaseFunc: BaseFuncProtocol {
    
    func getColor() -> Color {
        return .red
    }
}
struct ImplementBaseFunc2: BaseFuncProtocol {
    
    func getColor() -> Color {
        return .yellow
    }
}

class ViewModel: ObservableObject {
    let baseFunc: BaseFuncProtocol
    init(baseFunc: BaseFuncProtocol) {
        self.baseFunc = baseFunc
    }
    
    func getColor() -> Color {
        return baseFunc.getColor()
    }
    
    
}

struct ProtocolView: View {
    @StateObject var vm: ViewModel = ViewModel(baseFunc: ImplementBaseFunc2())
    let color: themeColorProtocol = ColorOne()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .foregroundColor(vm.getColor())
    }
}

struct ProtocolView_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolView()
    }
}
