//
//  SecondaryTitleLabel.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class SecondaryTitleLabel: UILabel {
    
    init(text: String = "", style: TextStyle = .ligth) {
        super.init(frame: .zero)
        self.text = text
        self.numberOfLines = 0
        self.textColor = style == .ligth ? .black : .white
        self.font = UIFont(name: "Helvetica Neue Medium", size: 15)
        self.translatesAutoresizingMaskIntoConstraints = false 
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
