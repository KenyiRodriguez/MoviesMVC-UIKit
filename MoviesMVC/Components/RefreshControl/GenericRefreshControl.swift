//
//  GenericRefreshControl.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 16/01/25.
//

import UIKit

class GenericRefreshControl: UIRefreshControl {
    private let onPullToRefresh: () -> Void
    
    init(onPullToRefresh: @escaping () -> Void) {
        self.onPullToRefresh = onPullToRefresh
        super.init()
        self.addTarget(self, action: #selector(self.onPullToRefreshHandler(_:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onPullToRefreshHandler(_ sender: UIRefreshControl) {
        self.onPullToRefresh()
    }
}
