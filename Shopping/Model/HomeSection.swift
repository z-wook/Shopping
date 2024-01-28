//
//  HomeSection.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

enum Section: Int, CaseIterable {
    case banner
    case horizontalProduct
    case verticalProduct
}

enum Item: Hashable {
    case banner(BannerInfo)
    case horizontalProduct(ProductInfo)
    case verticalProduct(ProductInfo)
}
