//
//  DetailRateViewModel.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

final class DetailRateViewModel: ObservableObject {
    @Published var rate: Int
    
    init(rate: Int) {
        self.rate = rate
    }
}
