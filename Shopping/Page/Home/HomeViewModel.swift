//
//  HomeViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import UIKit

class HomeViewModel: ObservableObject {
    enum Action {
        case loadData
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
    }
    
    final class State {
        struct CollectionViewModels {
            var bannerItems: [Item]?
            var horizontalProductItems: [Item]?
            var verticalProductItems: [Item]?
        }
        @Published var collectionViewModels = CollectionViewModels()
    }
    
    private(set) var state = State()
    private var loadDataTask: Task<Void, Never>?
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension HomeViewModel {
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
        case .getDataSuccess(let response):
            Task {
                await makeItems(response: response)
            }
        case .getDataFailure(let error):
            print("network error: \(error)")
            
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
    
    // 데이터를 받은 후 UI Update가 메인 스레드에서 동작해야 하므로 MainActor 사용
    @MainActor
    func makeItems(response: HomeResponse) async {
        state.collectionViewModels.bannerItems = response.banners.map { Item.banner($0) }
        state.collectionViewModels.horizontalProductItems = response.horizontalProducts.map { Item.horizontalProduct($0) }
        state.collectionViewModels.verticalProductItems = response.verticalProducts.map { Item.verticalProduct($0) }
    }
}
