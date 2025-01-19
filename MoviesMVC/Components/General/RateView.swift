//
//  RateView.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class RateView: UIStackView {
    
    private lazy var stars: [StarView] = {
        (0...9).map { _ in StarView(frame: .zero) }
    }()
    
    var value: Int = 0 {
        didSet {
            for (index, star) in self.stars.enumerated() {
                star.isRate = index < self.value
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.axis = .horizontal
        self.spacing = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.stars.forEach({ self.addArrangedSubview($0) })
    }
}

extension RateView {
    
    class StarView: UIImageView {
        
        var isRate: Bool = false {
            didSet {
                self.image = UIImage(systemName: self.isRate ? "star.fill" : "star")
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.setup()
        }
        
        private func setup() {
            self.image = UIImage(systemName: "star")
            self.tintColor = .systemOrange
            self.contentMode = .scaleAspectFit
            self.translatesAutoresizingMaskIntoConstraints = false
            self.heightAnchor.constraint(equalToConstant: 17).isActive = true
            self.widthAnchor.constraint(equalToConstant: 17).isActive = true
        }
    }
}
