//
//  HomeResponse.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

struct HomeResponse: Decodable {
    let banners: [BannerInfo]
    let horizontalProducts: [ProductInfo]
    let verticalProducts: [ProductInfo]
    let themes: [ThemeInfo]
}
