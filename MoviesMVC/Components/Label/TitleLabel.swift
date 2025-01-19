//
//  TitleLabel.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

enum TextStyle {
    case ligth
    case dark
}

class TitleLabel: UILabel {
    
    init(text: String = "", style: TextStyle = .ligth) {
        super.init(frame: .zero)
        self.text = text
        self.numberOfLines = 0
        self.textColor = style == .ligth ? .black : .white
        self.font = UIFont(name: "Helvetica Neue Bold", size: 21)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
