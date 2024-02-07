//
//  OptionViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import SwiftUI
import UIKit

final class OptionViewController: UIViewController {
    private let viewModel = OptionViewModel()
    private lazy var rootVC = UIHostingController(rootView: OptionRootView(viewModel: viewModel))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRootView()
    }
}

private extension OptionViewController {
    func addRootView() {
        view.addSubview(rootVC.view)
        
        rootVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
