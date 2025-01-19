//
//  DetailMovieView.swift
//  MoviesMVC-UIKit
//
//  Created by Kenyi Rodriguez on 18/01/25.
//

import UIKit
import SwiftUI
import Alamofire

protocol MovieViewDelegate: NSObjectProtocol {
    func detailMovieView(_ view: MovieViewProtocol, toogleFavorite movie: Movie)
}

protocol MovieViewProtocol {
    var delegate: MovieViewDelegate? { get set }
    var movie: Movie? { get set }
    func setFavoriteStyle(_  isFavorite: Bool)
    func showLoading(_ isLoading: Bool)
}

class MovieView: UIView {
    
    unowned var delegate: MovieViewDelegate?
    
    var movie: Movie? = nil {
        didSet { self.updateData() }
    }
    
    private lazy var scrollContent = GenericScrollView()
    private lazy var viewHeaderContent = EmptyView(backgroundColor: .clear)
    private lazy var movieInfoView = MovieInfoView()
    private lazy var imgMovieBackground = PictureBlurImageView(blurStyle: .dark)
    private lazy var lblDescription = TextLabel() 
    private lazy var lblGenres = TextLabel()
    private lazy var lblDescriptionInfo = TitleLabel(text: "Descripción:")
    private lazy var lblGenresInfo = TitleLabel(text: "Géneros:")
    
    private lazy var stkDescription = VerticalStackView(subviews: [self.lblGenresInfo, self.lblGenres, self.lblDescriptionInfo, self.lblDescription],
                                                        spacing: 10, alignment: .fill, distribution: .fill,
                                                        margins: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20))
    
    private lazy var stkFavorite = HorizontalStackView(subviews: [self.btnFavorite],
                                                       margins: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20))
    
    private lazy var stkContent = VerticalStackView(subviews: [self.viewHeaderContent ,self.stkDescription],
                                                    spacing: 20, alignment: .trailing, distribution: .fill)
    
    private lazy var btnFavorite = IconButton(icon: UIImage(systemName: "heart")) {
        guard let movie = self.movie else { return }
        self.delegate?.detailMovieView(self, toogleFavorite: movie)
    }

    init() {
        super.init(frame: .zero)
        self.addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieView: MovieViewProtocol {
    
    func setFavoriteStyle(_  isFavorite: Bool) {
        let image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
        self.btnFavorite.setImage(image, for: .normal)
    }
    
    func showLoading(_ isLoading: Bool) {
        self.scrollContent.isHidden = isLoading
        self.btnFavorite.isHidden = isLoading
    }
}

extension MovieView {
    
    private func updateData() {
        guard let movie = self.movie else { return }
        self.movieInfoView.movie = movie
        self.lblDescription.text = movie.overview
        self.lblGenres.text = movie.genresDescription
        
        let request = AF.request(movie.urlImage)
        request.response { dataResponse in
            guard
                let data = dataResponse.data,
                movie.urlImage == dataResponse.response?.url?.absoluteString
            else { return }
            let image = UIImage(data: data)
            self.imgMovieBackground.image = image
        }
    }
    
    private func addElements() {
        
        self.backgroundColor = .white
        self.addSubview(self.scrollContent)
        self.addSubview(self.btnFavorite)

        self.viewHeaderContent.addSubview(self.imgMovieBackground)
        self.viewHeaderContent.addSubview(self.movieInfoView)
        self.scrollContent.addSubview(self.stkContent)
        
        NSLayoutConstraint.activate([
            self.scrollContent.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.viewHeaderContent.heightAnchor.constraint(equalToConstant: 230),
            
            self.imgMovieBackground.topAnchor.constraint(equalTo: self.viewHeaderContent.topAnchor),
            self.imgMovieBackground.leadingAnchor.constraint(equalTo: self.viewHeaderContent.leadingAnchor),
            self.imgMovieBackground.trailingAnchor.constraint(equalTo: self.viewHeaderContent.trailingAnchor),
            self.imgMovieBackground.bottomAnchor.constraint(equalTo: self.viewHeaderContent.bottomAnchor),
            
            self.movieInfoView.topAnchor.constraint(equalTo: self.viewHeaderContent.topAnchor),
            self.movieInfoView.leadingAnchor.constraint(equalTo: self.viewHeaderContent.leadingAnchor),
            self.movieInfoView.trailingAnchor.constraint(equalTo: self.viewHeaderContent.trailingAnchor),
            self.movieInfoView.bottomAnchor.constraint(equalTo: self.viewHeaderContent.bottomAnchor),
            
            self.btnFavorite.trailingAnchor.constraint(equalTo: self.lblGenresInfo.trailingAnchor),
            self.btnFavorite.centerYAnchor.constraint(equalTo: self.lblGenresInfo.centerYAnchor),
                        
            self.stkContent.widthAnchor.constraint(equalTo: self.scrollContent.widthAnchor)
        ])
    }
}

fileprivate struct DetailMovieViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> MovieView {
        let view = MovieView()
        view.movie = Movie(dto: MovieDTO.mock)
        return view
    }
    
    func updateUIView(_ uiView: MovieView, context: Context) { }
}

fileprivate struct DetailMovieViewPreview: PreviewProvider {
    static var previews: some View { DetailMovieViewRepresentable() }
}
