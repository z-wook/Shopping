//
//  HomeViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private let homeViewModel = HomeViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        configure()
        setDataSource()
        bindViewModel()
        homeViewModel.loadData()
    }
}

private extension HomeViewController {
    func setLayout() {
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configure() {
        view.backgroundColor = UIColor.bk
    }
}

private extension HomeViewController {
    func bindViewModel() {
        homeViewModel.$bannerItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyItems()
            }
            .store(in: &cancellables)
        
        homeViewModel.$horizontalProductItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyItems()
            }
            .store(in: &cancellables)
        
        homeViewModel.$verticalProductItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyItems()
            }
            .store(in: &cancellables)
    }
    
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: homeView.homeCollectionView,
            cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
                guard let self else { return UICollectionViewCell() }
                switch itemIdentifier {
                case .banner(let item):
                    return self.setBannerCell(collectionView, indexPath, item)
                    
                case .horizontalProduct(let item):
                    return self.setProductCell(collectionView, indexPath, item)
                    
                case .verticalProduct(let item):
                    return self.setProductCell(collectionView, indexPath, item)
                }
            })
    }
    
    func applyItems() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        if let bannerItems = homeViewModel.bannerItems {
            snapShot.appendSections([.banner])
            snapShot.appendItems(bannerItems, toSection: .banner)
        }
        
        if let horizontalProductItems = homeViewModel.horizontalProductItems {
            snapShot.appendSections([.horizontalProduct])
            snapShot.appendItems(horizontalProductItems, toSection: .horizontalProduct)
        }
        
        if let verticalProductItems = homeViewModel.verticalProductItems {
            snapShot.appendSections([.verticalProduct])
            snapShot.appendItems(verticalProductItems, toSection: .verticalProduct)
        }
        dataSource?.apply(snapShot)
    }
}

private extension HomeViewController {
    func setBannerCell(_ collectionView: UICollectionView,
                       _ indexPath: IndexPath,
                       _ item: BannerInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCell.identifier,
            for: indexPath) as? BannerCell else { return UICollectionViewCell() }
        cell.setData(info: item)
        return cell
    }
    
    func setProductCell(_ collectionView: UICollectionView,
                        _ indexPath: IndexPath,
                        _ item: ProductInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCell.identifier,
            for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        cell.setData(info: item)
        return cell
    }
}

// MARK: - Preview
#Preview {
    HomeViewController()
}
