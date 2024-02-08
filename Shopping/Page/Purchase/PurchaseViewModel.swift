//
//  PurchaseViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import Foundation

final class PurchaseViewModel: ObservableObject {
    enum Action {
        case loadData
        case didTapPurchaseButton
    }
    
    struct State {
        var purchaseItems: [PurchaseSelectedItem]?
    }
    
    @Published private(set) var state = State()
    private(set) var showPaymentVC = PassthroughSubject<Void, Never>()
}

extension PurchaseViewModel {
    func process(action: Action) {
        switch action {
        case .loadData:
            Task {
                await loadData()
            }
            
        case .didTapPurchaseButton:
            Task {
                await didTapPurchaseButton()
            }
        }
    }
}

private extension PurchaseViewModel {
    @MainActor
    func loadData() async {
        state.purchaseItems = [
            PurchaseSelectedItem(title: "Vision Pro1", description: "New Product1"),
            PurchaseSelectedItem(title: "Vision Pro2", description: "New Product2"),
            PurchaseSelectedItem(title: "Vision Pro3", description: "New Product3"),
            PurchaseSelectedItem(title: "Vision Pro4", description: "New Product4"),
            PurchaseSelectedItem(title: "Vision Pro5", description: "New Product5"),
            PurchaseSelectedItem(title: "Vision Pro6", description: "New Product6"),
            PurchaseSelectedItem(title: "Vision Pro7", description: "New Product7"),
            PurchaseSelectedItem(title: "Vision Pro8", description: "New Product8"),
            PurchaseSelectedItem(title: "Vision Pro9", description: "New Product9"),
            PurchaseSelectedItem(title: "Vision Pro10", description: "New Product10"),
            PurchaseSelectedItem(title: "Vision Pro11", description: "New Product11"),
        ]
    }
    
    @MainActor
    func didTapPurchaseButton() async {
        showPaymentVC.send()
    }
}
