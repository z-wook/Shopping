//
//  HomeView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import UIKit

final class HomeView: UIView {
    lazy var homeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeView {
    func setLayout() {
        addSubview(homeCollectionView)
        
        homeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNum, _ -> NSCollectionLayoutSection in
            switch Section(rawValue: sectionNum) {
            case .banner:
                return BannerCell.bannerSection()
            case .horizontalProduct:
                return ProductCell.horizontalProductSection()
            case .verticalProduct:
                return ProductCell.verticalProductSection()
            case .none:
                return BannerCell.bannerSection()
            }
        }
    }
}
