//
//  PurchaseViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import UIKit

final class PurchaseViewController: UIViewController {
    private lazy var purchaseView = PurchaseView(subject: didTapPurchaseButton)
    private let viewModel = PurchaseViewModel()
    private var didTapPurchaseButton = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        view = purchaseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindView()
        bindViewModel()
        viewModel.process(action: .loadData)
    }
}

private extension PurchaseViewController {
    func bindView() {
        didTapPurchaseButton
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.viewModel.process(action: .didTapPurchaseButton)
            }.store(in: &cancellables)
    }
    
    func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self,
                      let purchaseSelectedItems = viewModel.state.purchaseItems else { return }
                purchaseView.setPurchaseItem(items: purchaseSelectedItems)
            }.store(in: &cancellables)
        
        viewModel.showPaymentVC
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                let paymentVC = PaymentViewController()
                self?.navigationController?.pushViewController(paymentVC, animated: true)
            }.store(in: &cancellables)
    }
}

#Preview {
    PurchaseViewController()
}
