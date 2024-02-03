//
//  FavoritesResponse.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

struct FavoritesResponse: Decodable {
    let favorites: [ProductInfo]
}
