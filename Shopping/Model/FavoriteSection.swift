//
//  FavoriteSection.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum FavoriteSection: Int, CaseIterable {
    case favorite
}

enum FavoriteItem: Hashable {
    case favorite(ProductInfo)
}
