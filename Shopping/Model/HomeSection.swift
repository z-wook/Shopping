//
//  HomeSection.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum HomeSection: Int, CaseIterable {
    case banner
    case horizontalProduct
    case separateLine1
    case couponButton
    case verticalProduct
    case separateLine2
    case theme
}

enum HomeItem: Hashable {
    case banner(BannerInfo)
    case horizontalProduct(ProductInfo)
    case separate1(SeparateInfo)
    case coupon(CouponInfo)
    case verticalProduct(ProductInfo)
    case separate2(SeparateInfo)
    case theme(ThemeInfo)
}
