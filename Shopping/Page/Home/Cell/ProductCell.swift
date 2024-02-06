//
//  ProductCell.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 12
        
        [imageView, labelStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        view.snp.makeConstraints {
            $0.width.equalTo(view.snp.height)
        }
        return view
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 13
        
        [productNameLabel, saleStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = SPColor.UIKit.bk
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var saleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5
        
        [discountReasonLabel, priceStack].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private var discountReasonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = SPColor.UIKit.keyColorRed2
        return label
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 1
        
        [originalPriceLabel, salePriceLabel].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private var originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = SPColor.UIKit.gray3Cool
        return label
    }()
    
    private var salePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = SPColor.UIKit.keyColorRed
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductCell {
    func setViewModel(info: ProductInfo) {
        let url = URL(string: info.imageUrl)
        imageView.kf.setImage(with: url)
        productNameLabel.text = info.title
        discountReasonLabel.text = info.discount
        originalPriceLabel.attributedText = NSMutableAttributedString(
            string: "\(info.originalPrice.moneyString)",
            attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        salePriceLabel.text = "\(info.discountPrice.moneyString)"
    }
}

extension ProductCell {
    static func horizontalProductSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(117),
                                               heightDimension: .estimated(224))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 40, leading: 31, bottom: 0, trailing: 31)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        return section
    }
    
    static func verticalProductSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .estimated(277))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(224))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 40, leading: 19 - 2.5, bottom: 0, trailing: 19 - 2.5)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 14
        return section
    }
}

private extension ProductCell {
    func setLayout() {
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
