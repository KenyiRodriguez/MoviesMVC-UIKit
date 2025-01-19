//
//  GenericCollectionView.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 16/01/25.
//

import UIKit

class GenericCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsVerticalScrollIndicator = false
        self.keyboardDismissMode = .onDrag
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
