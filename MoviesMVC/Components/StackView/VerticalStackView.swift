//
//  VerticalStackView.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(subviews: [UIView],
         spacing: CGFloat = 0,
         alignment: UIStackView.Alignment = .leading,
         distribution: UIStackView.Distribution = .fill,
         margins: UIEdgeInsets = .zero,
         backgroundColor: UIColor = .white,
         cornerRadius: CGFloat = 0) {
        
        super.init(frame: .zero)
        subviews.forEach({ self.addArrangedSubview($0) })
        self.axis = .vertical
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = margins
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
