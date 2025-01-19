//
//  IconButton.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class IconButton: UIButton {
    
    private let action: () -> Void
    
    init(icon: UIImage?, action: @escaping () -> Void) {
        self.action = action
        super.init(frame: .zero)
        self.setup(icon: icon)
    }
    
    func setup(icon: UIImage?) {
        self.addAction(UIAction { _ in
            self.action()
        }, for: .touchUpInside)
        
        self.setImage(icon, for: .normal)
        self.tintColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
