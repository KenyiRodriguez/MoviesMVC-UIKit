//
//  PictureBlurImageView.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class PictureBlurImageView: UIImageView {
    
    private var blurStyle: UIBlurEffect.Style = .dark
    
    private lazy var backgroundBlur: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: self.blurStyle))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(blurStyle: UIBlurEffect.Style, aspect: UIView.ContentMode = .scaleAspectFill, cornerRadius: CGFloat = 0) {
        self.blurStyle = blurStyle
        super.init(frame: .zero)
        self.setupBlur()
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.contentMode = aspect
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupBlur()
    }
    
    private func setupBlur() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.backgroundBlur)
        
        NSLayoutConstraint.activate([
            self.backgroundBlur.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundBlur.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundBlur.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundBlur.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
