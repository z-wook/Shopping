//
//  ThemeCell.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class ThemeCell: UICollectionViewCell {
    static let identifier = "ThemeCell"
    
    var themeImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
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

extension ThemeCell {
    func setViewModel(info: ThemeInfo) {
        let url = URL(string: info.imageUrl)
        themeImageView.kf.setImage(with: url)
    }
    
    static func themeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFactionalWidth: CGFloat = 0.7
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFactionalWidth),
                                               heightDimension: .fractionalWidth((142/286) * groupFactionalWidth))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        section.interGroupSpacing = 16
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let sectionHeader = ThemeHeaderView.headerSection()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

private extension ThemeCell {
    func setLayout() {
        contentView.addSubview(themeImageView)
        
        themeImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
