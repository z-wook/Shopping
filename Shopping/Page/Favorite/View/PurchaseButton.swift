//
//  PurchaseButton.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import UIKit

final class PurchaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCustomUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PurchaseButton {
    func setCustomUI() {
        setTitle("구매하기", for: .normal)
        setTitleColor(SPColor.UIKit.keyColorBlue, for: .normal)
        layer.borderColor = SPColor.UIKit.keyColorBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
