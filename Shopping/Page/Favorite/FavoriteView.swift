//
//  FavoriteView.swift
//  Shopping
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class FavoriteView: UIView {
    var favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FavoriteView {
    func setLayout() {
        addSubview(favoriteTableView)
        
        favoriteTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
