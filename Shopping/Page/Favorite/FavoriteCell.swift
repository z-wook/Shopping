//
//  FavoriteCell.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class FavoriteCell: UITableViewCell {
    static let identifier = "FavoriteCell"
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing =  20
        
        [productImageView, vStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private var productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 17
        
        [labelVStack, buttonHStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 13
        
        [titleLabel, priceLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = SPColor.bk
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = SPColor.bk
        return label
    }()
    
    private lazy var buttonHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        [purchaseButton, UIView()].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private var purchaseButton: UIButton = {
        let button = PurchaseButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        
        selectionStyle = .none
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteCell {
    func setViewModel(info: ProductInfo) {
        let url = URL(string: info.imageUrl)
        productImageView.kf.setImage(with: url)
        titleLabel.text = info.title
        priceLabel.text = info.originalPrice.moneyString
    }
}

private extension FavoriteCell {
    func setLayout() {
        contentView.addSubview(hStack)
        
        hStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(33)
            $0.top.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(40)
        }
    }
}
