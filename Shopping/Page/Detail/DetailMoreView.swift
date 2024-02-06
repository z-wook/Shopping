//
//  DetailMoreView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SwiftUI

struct DetailMoreView: View {
    @ObservedObject var viewModel: DetailMoreViewModel
    var moreTapped: () -> Void
    
    var body: some View {
        Button(action: {
            moreTapped()
        }, label: {
            HStack(alignment: .center, spacing: 10) {
                Text("상품정보 더보기")
                    .font(SPFont.SwiftUI.b17)
                    .foregroundStyle(SPColor.SwiftUI.keyColorBlue)
                SPImage.SwiftUI.down
                    .foregroundStyle(SPColor.SwiftUI.icon)
            }
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .border(SPColor.SwiftUI.keyColorBlue, width: 1)
        })
    }
}

#Preview {
    DetailMoreView(viewModel: DetailMoreViewModel(), moreTapped: { })
}
