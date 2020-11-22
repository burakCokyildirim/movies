//
//  DetailPresenter.swift
//  Movies
//
//  Created by Burak Çokyıldırım on 22.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class DetailPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: DetailViewControllerProtocol!
    fileprivate var interactor: DetailInteractorProtocol!
    fileprivate var delegate: DetailPresenterDelegateProtocol?
    
    // MARK: - Extras
    var movie: Movie? = nil
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: DetailViewControllerProtocol, interactor: DetailInteractorProtocol, delegate: DetailPresenterDelegateProtocol?, extras: Any?) {
        self.viewController = viewController
        self.interactor = interactor
        self.delegate = delegate
        
        // Store extras
        if let movie = extras as? Movie {
            self.movie = movie
        }
    }
    
    override func handleAndShowError(errorModel: ErrorModel) {
        viewController.showError(errorModel: errorModel, completionHandler: nil)
    }
    
    // MARK: - Business Logic
    
}

// MARK: - Extensions

// MARK: - Protocols Implemantations

// MARK: View Protocol

extension DetailPresenter: DetailPresenterViewProtocol {
    
    func fetchData() {
        if let movie = self.movie {
            viewController.startProgress()
            DispatchQueue.global().async {
                self.interactor.fetchData(imdbID: movie.imdbID)
                self.interactor.logData(movie: movie)
            }
        }
    }
}

// MARK: Interactor Protocol

extension DetailPresenter: DetailPresenterInteractorProtocol {
    
    func showMovieDetail(movieDetail: MovieDetail) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.viewController.stopProgress()
            self.viewController.showMovieDetail(movieDetail: movieDetail)
        }
    }
}

// MARK: Delegate Protocol

