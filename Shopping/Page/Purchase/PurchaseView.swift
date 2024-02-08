//
//  PurchaseView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import UIKit

final class PurchaseView: UIView {
    private var didTapCouponDownload: PassthroughSubject<Void, Never>
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [titleLable, purchaseStack].forEach {
            view.addSubview($0)
        }
        return view
    }()
    
    private var titleLable: UILabel = {
        let label = UILabel()
        label.font = SPFont.UIKit.b17
        label.textColor = SPColor.UIKit.bk
        label.text = "주문 상품 목록"
        return label
    }()
    
    private var purchaseStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 7
        return stack
    }()
    
    private lazy var purchaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("결제하기", for: .normal)
        button.setTitleColor(SPColor.UIKit.wh, for: .normal)
        button.titleLabel?.font = SPFont.UIKit.m16
        button.layer.backgroundColor = SPColor.UIKit.keyColorBlue.cgColor
        button.layer.cornerRadius = 5
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapCouponDownload.send()
        }), for: .touchUpInside)
        return button
    }()
    
    init(subject: PassthroughSubject<Void, Never>) {
        self.didTapCouponDownload = subject
        super.init(frame: .zero)
        
        configure()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PurchaseView {
    func setPurchaseItem(items: [PurchaseSelectedItem]) {
        purchaseStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        items.forEach {
            purchaseStack.addArrangedSubview(PurchaseSelectedItemView(item: $0))
        }
    }
}

private extension PurchaseView {
    func configure() {
        backgroundColor = .systemBackground
    }
    
    func setLayout() {
        [scrollView, purchaseButton].forEach {
            addSubview($0)
        }
        scrollView.addSubview(containerView)
        
        scrollView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(purchaseButton.snp.top)
        }
        
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        titleLable.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(33)
        }
        
        purchaseStack.snp.makeConstraints {
            $0.top.equalTo(titleLable.snp.bottom).offset(19)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(50)
        }
    }
}
