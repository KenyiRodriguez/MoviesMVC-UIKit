//
//  MovieCollectionViewCell.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit
import Alamofire

class MovieCollectionViewCell: UICollectionViewCell {
    
    private lazy var imgMovie = PictureImageView(width: 124, height: 190)    
    private lazy var lblTitle = TitleLabel()
    private lazy var lblReleaseDateInfo = TextLabel(text: "Fecha de lanzamiento:")
    private lazy var lblReleaseDate = TextLabel()
    private lazy var rateView = RateView()
    
    private lazy var stkDate = VerticalStackView(subviews: [self.lblReleaseDateInfo, self.lblReleaseDate],
                                                 spacing: 1)
    
    private lazy var stkInfo = VerticalStackView(subviews: [self.lblTitle, self.stkDate, self.rateView],
                                                 spacing: 10,
                                                 margins: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
 
    private lazy var stkContent = HorizontalStackView(subviews: [self.imgMovie, self.stkInfo],
                                                      spacing: 10,
                                                      cornerRadius: 10)
    
    var movie: Movie? {
        didSet { self.updateData() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addElements()
        self.setupView()
    }
}

extension MovieCollectionViewCell {
    
    private func updateData() {
        
        guard let movie = self.movie else { return }
        self.animateAppear()
        
        self.lblTitle.text = movie.title
        self.lblReleaseDate.text = movie.releaseDateFullFormat
        self.rateView.value = movie.voteAverage
        
        let request = AF.request(movie.urlImage)
        request.response { dataResponse in
            guard
                let data = dataResponse.data,
                movie.urlImage == dataResponse.response?.url?.absoluteString
            else { return }
            self.imgMovie.image = UIImage(data: data)
        }
    }
    
    func setupView() {
        self.backgroundColor = .clear
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        self.clipsToBounds = false
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
            self.stkContent.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

extension MovieCollectionViewCell {
    
    static var identifier: String { "MovieCollectionViewCell" }
    
    class func buildIn(_ collection: UICollectionView, indexPath: IndexPath, movie: Movie) -> Self {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? Self
        cell?.movie = movie
        return cell ?? Self()
    }
}
