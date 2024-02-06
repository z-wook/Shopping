//
//  SPFont.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SwiftUI
import UIKit

enum SPFont { }

extension SPFont {
    enum UIKit {
        static var r10: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular)
        
        static var r12: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        static var m12: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        static var b12: UIFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        static var r14: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static var b14: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        static var m16: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        static var b16: UIFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        static var l17: UIFont = UIFont.systemFont(ofSize: 17, weight: .light)
        static var m17: UIFont = UIFont.systemFont(ofSize: 17, weight: .medium)
        static var b17: UIFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        static var b20: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}

extension SPFont {
    enum SwiftUI {
        static var r10: Font = .system(size: 10, weight: .regular)
        
        static var r12: Font = .system(size: 12, weight: .regular)
        static var m12: Font = .system(size: 12, weight: .medium)
        static var b12: Font = .system(size: 12, weight: .bold)
        
        static var r14: Font = .system(size: 14, weight: .regular)
        static var b14: Font = .system(size: 14, weight: .bold)
        
        static var m16: Font = .system(size: 16, weight: .medium)
        static var b16: Font = .system(size: 16, weight: .bold)
        
        static var l17: Font = .system(size: 17, weight: .light)
        static var m17: Font = .system(size: 17, weight: .medium)
        static var b17: Font = .system(size: 17, weight: .bold)
        
        static var b20: Font = .system(size: 20, weight: .bold)
    }
}
