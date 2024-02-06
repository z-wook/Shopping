//
//  DetailBannerView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SwiftUI

struct DetailBannerView: View {
    @ObservedObject var viewModel: DetailBannerViewModel
    
    var body: some View {
        ScrollView.init(.horizontal) {
            LazyHStack(spacing: 0, content: {
                ForEach(viewModel.imageUrls, id: \.self) { imgeUrl in
                    KFImage(URL(string: imgeUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
            })
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.width)
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.never)
    }
}

#Preview {
    DetailBannerView(viewModel: DetailBannerViewModel(
        imageUrls: [
            "https://picsum.photos/id/1/500/500",
            "https://picsum.photos/id/2/500/500",
            "https://picsum.photos/id/3/500/500"]))
}
