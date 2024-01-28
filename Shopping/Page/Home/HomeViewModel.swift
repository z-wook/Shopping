//
//  HomeViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import UIKit

final class HomeViewModel: ObservableObject {
    private var loadDataTask: Task<Void, Never>?
    @Published var bannerItems: [Item]?
    @Published var horizontalProductItems: [Item]?
    @Published var verticalProductItems: [Item]?
    
    deinit {
        loadDataTask?.cancel()
    }
}

extension HomeViewModel {
    func loadData() {
        loadDataTask = Task {
            do {
                let response = try await NetworkManager.shared.getHomeData()
                await makeItems(response: response)
            } catch {
                print("network error: \(error)")
            }
        }
    }
}

private extension HomeViewModel {
    // 데이터를 받은 후 UI Update가 메인 스레드에서 동작해야 하므로 MainActor 사용
    @MainActor
    func makeItems(response: HomeResponse) async {
        bannerItems = response.banners.map { Item.banner($0) }
        horizontalProductItems = response.horizontalProducts.map { Item.horizontalProduct($0) }
        verticalProductItems = response.verticalProducts.map { Item.verticalProduct($0) }
    }
}
