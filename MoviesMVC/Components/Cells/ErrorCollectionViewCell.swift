//
//  ErrorCollectionViewCell.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit

@IBDesignable class ErrorCollectionViewCell: UICollectionViewCell {
    
    private lazy var lblErrorMessage: UILabel = {
        let lbl = UILabel()
        lbl.text = "lblErrorMessage"
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .darkGray
        lbl.font = UIFont(name: "Helvetica Neue Light Italic", size: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.widthAnchor.constraint(equalToConstant: 280).isActive = true
        return lbl
    }()
    
    private lazy var imgAlert: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "exclamationmark.triangle")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.widthAnchor.constraint(equalToConstant: 60).isActive = true
        img.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return img
    }()
    
    private lazy var stkContent: UIStackView = {
        let stk = UIStackView(arrangedSubviews: [self.imgAlert, self.lblErrorMessage])
        stk.axis = .vertical
        stk.alignment = .center
        stk.spacing = 29
        stk.translatesAutoresizingMaskIntoConstraints = false
        return stk
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addElements()
    }
}

extension ErrorCollectionViewCell {
    
    func updateData(_ errorMessage: String) {
        self.lblErrorMessage.text = errorMessage
    }

    private func addElements() {
        self.addSubview(self.stkContent)
        NSLayoutConstraint.activate([
            self.stkContent.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.stkContent.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

extension ErrorCollectionViewCell {
    
    static var identifier: String { "ErrorCollectionViewCell" }
    
    class func buildIn(_ collectionView: UICollectionView, indexPath: IndexPath, errorMessage: String) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? Self
        cell?.updateData(errorMessage)
        return cell ?? Self()
    }
}
