//
//  DetailPurchaseView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SwiftUI

struct DetailPurchaseView: View {
    @ObservedObject var viewModel: DetailPurchaseViewModel
    var favoriteTapped: () -> Void
    var purchaseTapped: () -> Void
    
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: favoriteTapped, label: {
                viewModel.isFavorite ? SPImage.SwiftUI.favoriteOn : SPImage.SwiftUI.favoriteOff
            })
            
            Button(action: purchaseTapped, label: {
                Text("구매하기")
                    .font(SPFont.SwiftUI.m16)
                    .foregroundStyle(SPColor.SwiftUI.wh)
            })
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .background(SPColor.SwiftUI.keyColorBlue)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .padding(.top, 10)
    }
}

#Preview {
    DetailPurchaseView(viewModel: DetailPurchaseViewModel(isFavorite: false),
                       favoriteTapped: {},
                       purchaseTapped: {})
}
