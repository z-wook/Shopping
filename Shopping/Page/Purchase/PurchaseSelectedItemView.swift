//
//  PurchaseSelectedItemView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class PurchaseSelectedItemView: UIView {
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        
        [titleLabel, descriptionLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = SPFont.UIKit.r12
        label.textColor = SPColor.UIKit.bk
        label.numberOfLines = 0
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = SPFont.UIKit.r12
        label.textColor = SPColor.UIKit.gray5
        return label
    }()
    
    init(item: PurchaseSelectedItem) {
        super.init(frame: .zero)
        
        setLayout()
        setBorder()
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PurchaseSelectedItemView {
    func setLayout() {
        addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    func setBorder() {
        layer.borderColor = SPColor.UIKit.gray0.cgColor
        layer.borderWidth = 1
    }
}
