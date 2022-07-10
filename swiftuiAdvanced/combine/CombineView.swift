//
//  CombineView.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 09/07/2022.
//

import SwiftUI

struct CombineView: View {
    @StateObject private var vm = CombineViewModel()
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) {
                        Text($0)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    if !vm.err.isEmpty {
                        Text(vm.err)
                    }
                }
                
                VStack {
                    ForEach(vm.dataBools, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    if !vm.err.isEmpty {
                        Text(vm.err)
                    }
                }
            }
        }
    }
}

struct CombineView_Previews: PreviewProvider {
    static var previews: some View {
        CombineView()
    }
}
