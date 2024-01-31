//
//  CouponInfo.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

struct CouponInfo: Hashable {
    enum CouponState {
        case enable
        case disable
    }
    
    var state: CouponState
}
