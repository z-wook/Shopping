//
//  ProductDetailResponse.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

struct ProductDetailResponse: Decodable {
    let bannerImages: [String]
    let product: ProductDetail
    let option: ProductDetailOption
    let detailImages: [String]
}

struct ProductDetail: Decodable {
    let name: String
    let discountPercent: Int
    let originalPrice: Int
    let discountPrice: Int
    let rate: Int
}

struct ProductDetailOption: Decodable {
    let type: String
    let name: String
    let image: String
}
