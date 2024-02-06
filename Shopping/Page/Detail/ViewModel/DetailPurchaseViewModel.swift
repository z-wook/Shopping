//
//  DetailPurchaseViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class DetailPurchaseViewModel: ObservableObject {
    @Published var isFavorite: Bool
    
    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}
