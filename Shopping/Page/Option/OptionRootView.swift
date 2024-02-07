//
//  OptionRootView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SwiftUI

struct OptionRootView: View {
    @ObservedObject var viewModel: OptionViewModel
    
    var body: some View {
        Text("옵션 화면")
    }
}

#Preview {
    OptionRootView(viewModel: OptionViewModel())
}
