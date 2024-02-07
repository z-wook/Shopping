//
//  PurchaseViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import UIKit

final class PurchaseViewController: UIViewController {
    private let purchaseView = PurchaseView()
    private let viewModel = PurchaseViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        view = purchaseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.process(action: .loadData)
    }
}

private extension PurchaseViewController {
    func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self,
                      let purchaseSelectedItems = viewModel.state.purchaseItems else { return }
                purchaseView.setPurchaseItem(items: purchaseSelectedItems)
            }.store(in: &cancellables)
    }
}

#Preview {
    PurchaseViewController()
}
