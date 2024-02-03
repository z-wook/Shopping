//
//  FavoriteViewController.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Combine
import SnapKit
import UIKit

final class FavoriteViewController: UIViewController {
    private let favoriteView = FavoriteView()
    private let favoriteViewModel = FavoriteViewModel()
    private var dataSource: UITableViewDiffableDataSource<FavoriteSection, FavoriteItem>?
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        view = favoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setDataSource()
        bindViewModel()
        favoriteViewModel.process(action: .getFavoriteFromAPI)
    }
}

private extension FavoriteViewController {
    func configure() {
        view.backgroundColor = UIColor.bk
        
        favoriteView.favoriteTableView.delegate = self
    }
    
    func bindViewModel() {
        favoriteViewModel.state.$tableViewModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyItems()
            }.store(in: &cancellables)
    }
}

private extension FavoriteViewController {
    func setDataSource() {
        dataSource = UITableViewDiffableDataSource(
            tableView: favoriteView.favoriteTableView,
            cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
                switch itemIdentifier {
                case .favorite(let item):
                    return self?.setFavoriteCell(tableView, indexPath, item)
                }
            })
    }
    
    func applyItems() {
        var snapShot = NSDiffableDataSourceSnapshot<FavoriteSection, FavoriteItem>()
        FavoriteSection.allCases.forEach {
            snapShot.appendSections([$0])
        }
        
        if let favoriteItems = favoriteViewModel.state.tableViewModel {
            snapShot.appendItems(favoriteItems, toSection: .favorite)
        }
        
        dataSource?.apply(snapShot)
    }
}

private extension FavoriteViewController {
    func setFavoriteCell(_ tableView: UITableView,
                         _ indexPath: IndexPath,
                         _ item: ProductInfo) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteCell.identifier,
            for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        cell.setViewModel(info: item)
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
}

#Preview {
    FavoriteViewController()
}
