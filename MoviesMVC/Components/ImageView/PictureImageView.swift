//
//  PictureImageView.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class PictureImageView: UIImageView {
    
    init(width: CGFloat, cornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        self.basicSetupWithCornerRadius(cornerRadius)
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    init(width: CGFloat, height: CGFloat, cornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        self.basicSetupWithCornerRadius(cornerRadius)
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    init(ratio: CGFloat, cornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        self.basicSetupWithCornerRadius(cornerRadius)
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: ratio).isActive = true
    }
    
    init(cornerRadius: CGFloat = 0, aspect: UIView.ContentMode = .scaleAspectFill) {
        super.init(frame: .zero)
        self.contentMode = aspect
        self.basicSetupWithCornerRadius(cornerRadius)
    }
    
    private func basicSetupWithCornerRadius(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = .systemIndigo
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
