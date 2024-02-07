//
//  DetailViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import Foundation

final class DetailViewModel: ObservableObject {
    enum Action {
        case loadData
        case loading(Bool)
        case getDataSuccess(ProductDetailResponse)
        case getDataFailure(Error)
        case didTapChangeOption
        case didTapMore
        case didTapFavorite
        case didTapPurchase
    }
    
    struct State {
        var isError: String?
        var isLoading: Bool = false
        var bannerVM: DetailBannerViewModel?
        var rateVM: DetailRateViewModel?
        var title: String?
        var optionVM: DetailOptionViewModel?
        var priceVM: DetailPriceViewModel?
        var mainImageUrls: [String]?
        var moreVM: DetailMoreViewModel?
        var purchaseVM: DetailPurchaseViewModel?
    }
    
    @Published private(set) var state = State()
    private(set) var showOptionVC = PassthroughSubject<Void, Never>()
    private(set) var showPurchaseVC = PassthroughSubject<Void, Never>()
    private var loadDataTask: Task<Void, Never>?
    private var isFavorite: Bool = false
    private var needShowMore: Bool = true
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension DetailViewModel {
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
            
        case .loading(let loading):
            Task {
                await toggleLoading(isLoading: loading)
            }
            
        case .getDataSuccess(let response):
            Task {
                await transformProductDetailResponse(response: response)
            }
            
        case .getDataFailure(let error):
            Task {
                await getDataFailure(error: error)
            }
            
        case .didTapChangeOption:
            showOptionVC.send()
            
        case .didTapMore:
            Task {
                await toggleMore()
            }
            
        case .didTapFavorite:
            Task {
                await toggleFavorite()
            }
            
        case .didTapPurchase:
            showPurchaseVC.send()
        }
    }
}

private extension DetailViewModel {
    func loadData() {
        loadDataTask = Task {
            defer {
                process(action: .loading(false))
            }
            do {
                process(action: .loading(true))
                let response = try await NetworkManager.shared.getProductDetailData()
                process(action: .getDataSuccess(response))
            } catch {
                process(action: .getDataFailure(error))
            }
        }
    }
    
    @MainActor
    func toggleLoading(isLoading: Bool) async {
        state.isLoading = isLoading
    }
    
    @MainActor
    func toggleFavorite() async {
        isFavorite.toggle()
        state.purchaseVM = DetailPurchaseViewModel(isFavorite: isFavorite)
    }
    
    @MainActor
    func toggleMore() async {
        needShowMore = false
        state.moreVM = needShowMore ? DetailMoreViewModel() : nil
    }
    
    @MainActor
    func transformProductDetailResponse(response: ProductDetailResponse) async {
        state.isError = nil
        state.bannerVM = DetailBannerViewModel(imageUrls: response.bannerImages)
        state.rateVM = DetailRateViewModel(rate: response.product.rate)
        state.title = response.product.name
        state.optionVM = DetailOptionViewModel(type: response.option.type,
                                               name: response.option.name,
                                               imageUrl: response.option.image)
        state.priceVM = DetailPriceViewModel(discountRate: "\(response.product.discountPercent)%",
                                             originPrice: "\(response.product.originalPrice)",
                                             currentPrice: "\(response.product.discountPrice)",
                                             shippingType: "무료배송")
        state.mainImageUrls = response.detailImages
        state.moreVM = needShowMore ? DetailMoreViewModel() : nil
        state.purchaseVM = DetailPurchaseViewModel(isFavorite: isFavorite)
    }
    
    @MainActor
    func getDataFailure(error: Error) async {
        state.isError = "Error: \(error.localizedDescription)"
    }
}
