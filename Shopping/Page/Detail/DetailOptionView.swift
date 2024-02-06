//
//  DetailOptionView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SwiftUI

struct DetailOptionView: View {
    @ObservedObject var viewModel: DetailOptionViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.type)
                    .foregroundStyle(SPColor.SwiftUI.gray5)
                    .font(SPFont.SwiftUI.r12)
                Text(viewModel.name)
                    .foregroundStyle(SPColor.SwiftUI.bk)
                    .font(SPFont.SwiftUI.b14)
            }
            Spacer()
            KFImage(URL(string: viewModel.imageUrl))
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    DetailOptionView(viewModel: DetailOptionViewModel(
        type: "색상",
        name: "코랄",
        imageUrl: "https://picsum.photos/id/3/500/500")
    )
}
