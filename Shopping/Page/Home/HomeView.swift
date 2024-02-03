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
        collectionView.register(BannerCell.self,
                                forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(ProductCell.self,
                                forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.register(SeparateLineCell.self,
                                forCellWithReuseIdentifier: SeparateLineCell.identifier)
        collectionView.register(CouponButtonCell.self,
                                forCellWithReuseIdentifier: CouponButtonCell.identifier)
        collectionView.register(ThemeCell.self,
                                forCellWithReuseIdentifier: ThemeCell.identifier)
        collectionView.register(ThemeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ThemeHeaderView.identifier)
        collectionView.setCollectionViewLayout(collectionViewLayout(), animated: true)
        return collectionView
    }()
    
    var rightButtonItem: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(SPImage.favoriteOn, for: .normal)
        return button
    }()
    
    var leftButtonItem: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(SPImage.menu, for: .normal)
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

private extension HomeView {
    func setLayout() {
        addSubview(homeCollectionView)
        
        homeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionNum, _ in
            guard let self = self else { return nil }
            switch HomeSection(rawValue: sectionNum) {
            case .banner:
                return BannerCell.bannerSection()
                
            case .horizontalProduct:
                return ProductCell.horizontalProductSection()
                
            case .separateLine1, .separateLine2:
                return SeparateLineCell.separateSection()
                
            case .couponButton:
                return CouponButtonCell.couponButtonSection()
                
            case .verticalProduct:
                return ProductCell.verticalProductSection()
                
            case .theme:
                return ThemeCell.themeSection()
                
            case .none:
                return nil
            }
        }
    }
}
