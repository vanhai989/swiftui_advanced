//
//  FutureView.swift
//  swiftuiAdvanced
//
//  Created by Hai Dev on 10/07/2022.
//

import SwiftUI

struct FutureView: View {
    @StateObject private var vm = FutureViewModel()
    var body: some View {
        Text(vm.title)
    }
}

struct FutureView_Previews: PreviewProvider {
    static var previews: some View {
        FutureView()
    }
}
