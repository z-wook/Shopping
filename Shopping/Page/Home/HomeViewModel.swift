//
//  HomeViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import UIKit

final class HomeViewModel {
    func makeItems(response: HomeResponse) -> (banner: [Item], horizontalProduct: [Item], verticalProduct: [Item]) {
        let bannerItems = response.banners.map { Item.banner($0) }
        let horizontalProductItems = response.horizontalProducts.map { Item.horizontalProduct($0) }
        let verticalProductItems = response.verticalProducts.map { Item.verticalProduct($0) }
        return (bannerItems, horizontalProductItems, verticalProductItems)
        response.themes
    }
}
