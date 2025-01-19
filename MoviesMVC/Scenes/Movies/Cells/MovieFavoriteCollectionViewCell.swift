//
//  MovieShortCollectionViewCell.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit
import Alamofire

class MovieFavoriteCollectionViewCell: UICollectionViewCell {
    
    private lazy var imgMovie = PictureImageView(ratio: 256/175, cornerRadius: 10)
    private lazy var lblTitle = SecondaryTitleLabel()
    private lazy var lblReleaseDate = SecondaryTextLabel()
    
    private lazy var stkInfo = VerticalStackView(subviews: [self.lblTitle, self.lblReleaseDate],
                                                 spacing: 2,
                                                 alignment: .leading,
                                                 distribution: .fill)
    
    private lazy var stkContent = VerticalStackView(subviews: [self.imgMovie, self.stkInfo], spacing: 5)
    
    var movie: Movie? {
        didSet { self.updateData() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addElements()
    }
}

extension MovieFavoriteCollectionViewCell {
    
    private func updateData() {
        
        self.backgroundColor = .red
        guard let movie = self.movie else { return }
        self.animateAppear()
        
        self.lblTitle.text = movie.title
        self.lblReleaseDate.text = movie.releaseDateFullFormat

        let request = AF.request(movie.urlImage)
        request.response { dataResponse in
            guard let data = dataResponse.data else { return }
            self.imgMovie.image = UIImage(data: data)
        }
    }

    private func animateAppear() {
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    private func addElements() {
        self.addSubview(self.stkContent)
        NSLayoutConstraint.activate([
            self.stkContent.topAnchor.constraint(equalTo: self.topAnchor),
            self.stkContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stkContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stkContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imgMovie.leadingAnchor.constraint(equalTo: self.stkContent.leadingAnchor),
            self.imgMovie.trailingAnchor.constraint(equalTo: self.stkContent.trailingAnchor)
        ])
    }
}

extension MovieFavoriteCollectionViewCell {
    
    static var identifier: String { "MovieFavoriteCollectionViewCell" }
    
    class func buildIn(_ collection: UICollectionView, indexPath: IndexPath, movie: Movie) -> MovieFavoriteCollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? MovieFavoriteCollectionViewCell
        cell?.movie = movie
        return cell ?? MovieFavoriteCollectionViewCell()
    }
}
