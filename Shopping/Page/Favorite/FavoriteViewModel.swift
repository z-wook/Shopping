//
//  FavoriteViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class FavoriteViewModel {
    enum Action {
        case getFavoriteFromAPI
        case getFavoriteSuccess(FavoritesResponse)
        case getFavoriteFailure(Error)
        case didTappedPurchaseButton
    }
    
    final class State {
        @Published var tableViewModel: [FavoriteItem]?
    }
    
    private(set) var state = State()
}

extension FavoriteViewModel {
    func process(action: Action) {
        switch action {
        case .getFavoriteFromAPI:
            getFavoriteFromAPI()
            
        case .getFavoriteSuccess(let response):
            getFavoriteSuccess(response: response)
            
        case .getFavoriteFailure(let error):
            print("network error: \(error)")
            
        case .didTappedPurchaseButton:
            break
        }
    }
}

private extension FavoriteViewModel {
    func getFavoriteFromAPI() {
        Task {
            do {
                let response = try await NetworkManager.shared.getFavoriteData()
                process(action: .getFavoriteSuccess(response))
            } catch {
                process(action: .getFavoriteFailure(error))
            }
        }
    }
    
    func getFavoriteSuccess(response: FavoritesResponse) {
        Task {
            await makeItems(response: response)
        }
    }
}

private extension FavoriteViewModel {
    @MainActor
    func makeItems(response: FavoritesResponse) async {
        state.tableViewModel = response.favorites.map { FavoriteItem.favorite($0) }
    }
}
