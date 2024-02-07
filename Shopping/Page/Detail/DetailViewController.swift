//
//  DetailViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import SwiftUI
import UIKit

final class DetailViewController: UIViewController {
    private let viewModel = DetailViewModel()
    private lazy var rootVC = UIHostingController(rootView: DetailRootView(viewModel: viewModel))
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRootView()
        bindViewModel()
    }
}

private extension DetailViewController {
    func addRootView() {
        view.addSubview(rootVC.view)
        
        rootVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.showOptionVC
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                let optionVC = OptionViewController()
                self?.navigationController?.pushViewController(optionVC, animated: true)
            }.store(in: &cancellables)
        
        viewModel.showPurchaseVC
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                let purchaseVC = PurchaseViewController()
                self?.navigationController?.pushViewController(purchaseVC, animated: true)
            }.store(in: &cancellables)
    }
}

#Preview {
    DetailViewController()
}
