//
//  TextLabel.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

class TextLabel: UILabel {
    
    init(text: String = "", style: TextStyle = .ligth) {
        super.init(frame: .zero)
        self.text = text
        self.numberOfLines = 0
        self.textColor = style == .ligth ? .darkGray : .white
        self.font = UIFont(name: "Helvetica Neue Light Italic", size: 15)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
