//
//  DetailPriceView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SwiftUI

struct DetailPriceView: View {
    @ObservedObject var viewModel: DetailPriceViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 21) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 0) {
                    Text(viewModel.discountRate)
                        .foregroundStyle(SPColor.SwiftUI.icon)
                        .font(SPFont.SwiftUI.b14)
                    
                    Text(viewModel.originPrice)
                        .foregroundStyle(SPColor.SwiftUI.gray5)
                        .font(SPFont.SwiftUI.b16)
                        .strikethrough()
                }
                Text(viewModel.currentPrice)
                    .foregroundStyle(SPColor.SwiftUI.keyColorRed)
                    .font(SPFont.SwiftUI.b20)
            }
            Text(viewModel.shippingType)
                .foregroundStyle(SPColor.SwiftUI.icon)
                .font(SPFont.SwiftUI.r12)
        }
    }
}

#Preview {
    DetailPriceView(viewModel: DetailPriceViewModel(
        discountRate: "53%",
        originPrice: "300,000원",
        currentPrice: "129,000원",
        shippingType: "무료배송"))
}
