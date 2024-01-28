//
//  HomeViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private let homeViewModel = HomeViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setLayout()
        configure()
        setDataSource()
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
    
    func applyItems(bannerData: [Item], horizontalData: [Item], verticalData: [Item]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        Section.allCases.forEach {
            snapShot.appendSections([$0])
        }
        snapShot.appendItems(bannerData, toSection: .banner)
        snapShot.appendItems(horizontalData, toSection: .horizontalProduct)
        snapShot.appendItems(verticalData, toSection: .verticalProduct)
        dataSource?.apply(snapShot)
    }
    
    func loadData() {
        Task {
            do {
                let response = try await NetworkManager.shared.getHomeData()
                let items = homeViewModel.makeItems(response: response)
                applyItems(
                    bannerData: items.banner,
                    horizontalData: items.horizontalProduct,
                    verticalData: items.verticalProduct)
            } catch {
                print("network error: \(error)")
            }
        }
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
