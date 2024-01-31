//
//  BannerCell.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class BannerCell: UICollectionViewCell {
    static let identifier = "BannerCell"
    
    private var bannerImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerCell {
    func setViewModel(info: BannerInfo) {
        let url = URL(string: info.imageUrl)
        bannerImageView.kf.setImage(with: url)
    }
    
    static func bannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(165/393))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}

private extension BannerCell {
    func setLayout() {
        contentView.addSubview(bannerImageView)
        
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
