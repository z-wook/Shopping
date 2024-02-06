//
//  CouponButtonCell.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import UIKit

final class CouponButtonCell: UICollectionViewCell {
    static let identifier = "CouponButtonCell"
    private weak var didTapCouponDownload: PassthroughSubject<Void, Never>?
    
    lazy var couponButton: UIButton = {
        let button = UIButton()
        button.setImage(SPImage.UIKit.buttonActivate, for: .normal)
        button.setImage(SPImage.UIKit.buttonComplete, for: .disabled)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTappedCouponBtn), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CouponButtonCell {
    func setViewModel(info: CouponInfo, subject: PassthroughSubject<Void, Never>) {
        didTapCouponDownload = subject
        couponButton.isEnabled = switch info.state {
        case .enable:
            true
        case .disable:
            false
        }
    }
    
    static func couponButtonSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(37))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 28, leading: 22, bottom: 0, trailing: 22)
        return section
    }
}

private extension CouponButtonCell {
    func setLayout() {
        contentView.addSubview(couponButton)
        
        couponButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func didTappedCouponBtn() {
        didTapCouponDownload?.send()
    }
}
