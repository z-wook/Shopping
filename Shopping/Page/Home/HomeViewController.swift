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
    private var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>?
    private var didTapCouponDownload = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var leftBarBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: SPImage.UIKit.menu,
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton))
        return button
    }()
    
    private lazy var rightBarBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: SPImage.UIKit.favoriteOn,
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton))
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setDataSource()
        setHeader()
        bindViewModel()
        homeViewModel.process(action: .loadData)
        homeViewModel.process(action: .loadCoupon)
    }
}

private extension HomeViewController {
    func configure() {
        navigationItem.leftBarButtonItem = leftBarBtn
        navigationItem.rightBarButtonItem = rightBarBtn
        
        homeView.homeCollectionView.delegate = self
    }
    
    func bindViewModel() {
        homeViewModel.state.$collectionViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyItems()
            }
            .store(in: &cancellables)
        
        didTapCouponDownload
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.homeViewModel.process(action: .didTapCouponButton)
            }.store(in: &cancellables)
    }
    
    @objc func didTappedLeftBarButton() {
        
    }
    
    @objc func didTappedRightBarButton() {
        let favoriteVC = FavoriteViewController()
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
}

private extension HomeViewController {
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: homeView.homeCollectionView,
            cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
                switch itemIdentifier {
                case .banner(let item):
                    return self?.setBannerCell(collectionView, indexPath, item)
                    
                case .horizontalProduct(let item):
                    return self?.setProductCell(collectionView, indexPath, item)
                    
                case .separate1(_):
                    return self?.setSeparateLineCell(collectionView, indexPath)
                    
                case .coupon(let item):
                    return self?.setCouponCell(collectionView, indexPath, item)
                    
                case .verticalProduct(let item):
                    return self?.setProductCell(collectionView, indexPath, item)
                    
                case .separate2(_):
                    return self?.setSeparateLineCell(collectionView, indexPath)
                    
                case .theme(let item):
                    return self?.setThemeCell(collectionView, indexPath, item)
                }
            })
    }
    
    func setHeader() {
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, IndexPath in
            guard let self = self,
                  let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: ThemeHeaderView.identifier,
                    for: IndexPath) as? ThemeHeaderView else { return UICollectionReusableView() }
            header.setViewModel(title: homeViewModel.state.collectionViewModels.themeItems?.title)
            return header
        }
    }
    
    func applyItems() {
        var snapShot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
        HomeSection.allCases.forEach {
            snapShot.appendSections([$0])
        }
        
        if let bannerItems = homeViewModel.state.collectionViewModels.bannerItems {
            snapShot.appendItems(bannerItems, toSection: .banner)
        }
        
        if let horizontalProductItems = homeViewModel.state.collectionViewModels.horizontalProductItems {
            snapShot.appendItems(horizontalProductItems, toSection: .horizontalProduct)
            snapShot.appendItems([HomeItem.separate1(.init())], toSection: .separateLine1)
        }
        
        if let verticalProductItems = homeViewModel.state.collectionViewModels.verticalProductItems,
           let couponItems = homeViewModel.state.collectionViewModels.couponItems {
            snapShot.appendItems(couponItems, toSection: .couponButton) // 비동기 처리 완료되면 같이 업데이트하기 위함
            snapShot.appendItems(verticalProductItems, toSection: .verticalProduct)
            snapShot.appendItems([HomeItem.separate2(.init())], toSection: .separateLine2)
        }
        
        if let themeItems = homeViewModel.state.collectionViewModels.themeItems {
            snapShot.appendItems(themeItems.item, toSection: .theme)
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
        cell.setViewModel(info: item)
        return cell
    }
    
    func setProductCell(_ collectionView: UICollectionView,
                        _ indexPath: IndexPath,
                        _ item: ProductInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCell.identifier,
            for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        cell.setViewModel(info: item)
        return cell
    }
    
    func setCouponCell(_ collectionView: UICollectionView,
                       _ indexPath: IndexPath,
                       _ item: CouponInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CouponButtonCell.identifier,
            for: indexPath) as? CouponButtonCell else { return UICollectionViewCell() }
        cell.setViewModel(info: item, subject: didTapCouponDownload)
        return cell
    }
    
    func setSeparateLineCell(_ collectionView: UICollectionView,
                             _ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SeparateLineCell.identifier,
            for: indexPath) as? SeparateLineCell else { return UICollectionViewCell() }
        return cell
    }
    
    func setThemeCell(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ item: ThemeInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ThemeCell.identifier,
            for: indexPath) as? ThemeCell else { return UICollectionViewCell() }
        cell.setViewModel(info: item)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let sections = dataSource?.snapshot().sectionIdentifiers else { return }
        switch sections[indexPath.section] {
        case .banner, .couponButton, .theme:
            break
            
        case .separateLine1, .separateLine2:
            break
            
        case .horizontalProduct, .verticalProduct:
            let detailVC = DetailViewController()
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - Preview
#Preview {
    HomeViewController()
}
