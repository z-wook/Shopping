//
//  DetailViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import SwiftUI
import UIKit

final class DetailViewController: UIViewController {
    private let viewModel = DetailViewModel()
    private lazy var rootVC = UIHostingController(rootView: DetailRootView(viewModel: viewModel))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRootView()
    }
}

private extension DetailViewController {
    func addRootView() {
        view.addSubview(rootVC.view)
        
        rootVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

#Preview {
    DetailViewController()
}
