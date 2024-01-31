//
//  HomeViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import UIKit

final class HomeViewModel {
    enum Action {
        case loadData
        case loadCoupon
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
        case getCouponSuccess(Bool)
        case didTapCouponButton
    }
    
    final class State {
        struct CollectionViewModels {
            var bannerItems: [Item]?
            var horizontalProductItems: [Item]?
            var couponItems: [Item]?
            var verticalProductItems: [Item]? 
            var themeItems: (title: String, item: [Item])?
        }
        @Published var collectionViewModels = CollectionViewModels()
    }
    
    private(set) var state = State()
    private var loadDataTask: Task<Void, Never>?
    private let couponDownloadKey = "CouponDownload"
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension HomeViewModel {
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
            
        case .loadCoupon:
            loadCoupon()
            
        case .getDataSuccess(let response):
            Task {
                await makeItems(response: response)
            }
            
        case .getDataFailure(let error):
            print("network error: \(error)")
            
        case .getCouponSuccess(let state):
            Task {
                await transformCoupon(isEnabled: state)
            }
        case .didTapCouponButton:
             downLoadCoupon()
        }
    }
}

private extension HomeViewModel {
    func loadData() {
        loadDataTask = Task {
            do {
                let response = try await NetworkManager.shared.getHomeData()
                process(action: .getDataSuccess(response))
            } catch {
                process(action: .getDataFailure(error))
            }
        }
    }
    
    func loadCoupon() {
        let couponState = UserDefaults.standard.bool(forKey: couponDownloadKey)
        process(action: .getCouponSuccess(couponState))
    }
    
    func downLoadCoupon() {
        UserDefaults.standard.setValue(true, forKey: couponDownloadKey)
        process(action: .loadCoupon)
    }
}

private extension HomeViewModel {
    // 데이터를 받은 후 UI Update가 메인 스레드에서 동작해야 하므로 MainActor 사용
    @MainActor
    func makeItems(response: HomeResponse) async {
        state.collectionViewModels.bannerItems = response.banners.map { Item.banner($0) }
        state.collectionViewModels.horizontalProductItems = response.horizontalProducts.map { Item.horizontalProduct($0) }
        state.collectionViewModels.verticalProductItems = response.verticalProducts.map { Item.verticalProduct($0) }
        state.collectionViewModels.themeItems = ("테마관" , response.themes.map { Item.theme($0) })
    }
    
    @MainActor
    func transformCoupon(isEnabled: Bool) async {
        state.collectionViewModels.couponItems = [Item.coupon(CouponInfo(state: isEnabled ? .disable : .enable))]
    }
}
