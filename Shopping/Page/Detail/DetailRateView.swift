//
//  DetailRateView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SwiftUI

struct DetailRateView: View {
    @ObservedObject var viewModel: DetailRateViewModel
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<viewModel.rate, id: \.self) { _ in
                starImage
                    .foregroundStyle(SPColor.SwiftUI.yellow)
            }
            
            ForEach(0..<(5 - viewModel.rate), id: \.self) { _ in
                starImage
                    .foregroundStyle(SPColor.SwiftUI.gray2)
            }
        }
    }
}

private extension DetailRateView {
    var starImage: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 16, height: 16)
    }
}

#Preview {
    DetailRateView(viewModel: DetailRateViewModel(rate: 4))
}
