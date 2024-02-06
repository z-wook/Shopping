//
//  DetailRootView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SwiftUI

struct DetailRootView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    bannerView
                    rateView
                    titleView
                    optionView
                    priceView
                    mainImageView
                }
            }
            moreView
            purchaseView
        }
        .onAppear(perform: {
            viewModel.process(action: .loadData)
        })
    }
}

private extension DetailRootView {
    @ViewBuilder
    var bannerView: some View {
        if let bannerVM = viewModel.state.bannerVM {
            DetailBannerView(viewModel: bannerVM)
                .padding(.bottom, 15)
        }
    }
    
    @ViewBuilder
    var rateView: some View {
        if let rateVM = viewModel.state.rateVM {
            HStack(spacing: 0) {
                Spacer()
                DetailRateView(viewModel: rateVM)
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        if let title = viewModel.state.title {
            HStack(spacing: 0) {
                Text(title)
                    .font(SPFont.SwiftUI.m17)
                    .foregroundStyle(SPColor.SwiftUI.bk)
                Spacer()
            }
            .padding([.horizontal, .bottom], 20)
            Spacer()
        }
    }
    
    @ViewBuilder
    var optionView: some View {
        if let optionVM = viewModel.state.optionVM {
            Group {
                DetailOptionView(viewModel: optionVM)
                    .padding(.bottom, 32)
                
                HStack(spacing: 0) {
                    Spacer()
                    Button(action: {
                        viewModel.process(action: .didTapChangeOption)
                    }, label: {
                        Text("옵션 선택하기")
                            .font(SPFont.SwiftUI.m12)
                            .foregroundStyle(SPColor.SwiftUI.keyColorBlue)
                    })
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    var priceView: some View {
        if let priceVM = viewModel.state.priceVM {
            HStack(spacing: 0) {
                DetailPriceView(viewModel: priceVM)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
    }
    
    @ViewBuilder
    var mainImageView: some View {
        if let mainImages = viewModel.state.mainImageUrls {
            LazyVStack(spacing: 0) {
                ForEach(mainImages, id: \.self) {
                    let url = URL(string: $0)
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .padding(.bottom, 32)
            .frame(maxHeight: viewModel.state.moreVM == nil ? .infinity : 200, alignment: .top)
            .clipped()
        }
    }
    
    @ViewBuilder
    var moreView: some View {
        if let moreVM = viewModel.state.moreVM {
            DetailMoreView(viewModel: moreVM) {
                viewModel.process(action: .didTapMore)
            }
        }
    }
    
    @ViewBuilder
    var purchaseView: some View {
        if let purchaseVM = viewModel.state.purchaseVM {
            DetailPurchaseView(viewModel: purchaseVM) {
                viewModel.process(action: .didTapFavorite)
            } purchaseTapped: {
                viewModel.process(action: .didTapPurchase)
            }
            .padding([.horizontal, .bottom], 25)
        }
    }
}

#Preview {
    DetailRootView(viewModel: DetailViewModel())
}
