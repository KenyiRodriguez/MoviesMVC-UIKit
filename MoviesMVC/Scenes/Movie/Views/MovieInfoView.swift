//
//  MovieLargeView.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit
import Alamofire

class MovieInfoView: HorizontalStackView {
    
    private lazy var imgMovie = PictureImageView(width: 134, cornerRadius: 10)
    private lazy var lblTitle = TitleLabel(style: .dark)
    private lazy var lblReleaseDateInfo = TextLabel(text: "Fecha de lanzamiento:", style: .dark)
    private lazy var lblReleaseDate = TextLabel(style: .dark)
    private lazy var rateView = RateView()
    
    private lazy var stkDate = VerticalStackView(subviews: [self.lblReleaseDateInfo, self.lblReleaseDate],
                                                 spacing: 1,
                                                 backgroundColor: .clear)
    
    private lazy var stkInfoMovie = VerticalStackView(subviews: [self.lblTitle, self.stkDate, self.rateView],
                                                      spacing: 10,
                                                      backgroundColor: .clear)
    
    var movie: Movie? {
        didSet { self.updateData() }
    }
    
    private func updateData() {
        
        guard let movie = self.movie else { return }
        self.lblTitle.text = movie.title
        self.lblReleaseDate.text = movie.releaseDateFullFormat
        self.rateView.value = movie.voteAverage
        
        let request = AF.request(movie.urlImage)
        request.response { dataResponse in
            guard
                let data = dataResponse.data,
                movie.urlImage == dataResponse.response?.url?.absoluteString
            else { return }
            let image = UIImage(data: data)
            self.imgMovie.image = image
        }
    }
    
    init() {
        super.init(subviews: [],
                   spacing: 10,
                   margins: UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10),
                   backgroundColor: .clear)
        self.addArrangedSubview(self.imgMovie)
        self.addArrangedSubview(self.stkInfoMovie)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
