//
//  SplashPresenter.swift
//  Movies
//
//  Created by Burak Çokyıldırım on 21.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Burak Cokyildirim
//

import Foundation

class SplashPresenter: BasePresenter {
    
    // MARK: - Dependencies
    
    fileprivate var viewController: SplashViewControllerProtocol!
    fileprivate var interactor: SplashInteractorProtocol!
    fileprivate var delegate: SplashPresenterDelegateProtocol?
    
    // MARK: - Extras
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    init(viewController: SplashViewControllerProtocol, interactor: SplashInteractorProtocol, delegate: SplashPresenterDelegateProtocol?, extras: Any?) {
        self.viewController = viewController
        self.interactor = interactor
        self.delegate = delegate
        
        // Store extras
    }
    
    // MARK: - Business Logic
    
    override func handleAndShowError(errorModel: ErrorModel) {
        
        DispatchQueue.main.async {
            self.viewController.showError(errorModel: errorModel, completionHandler: nil)
        }
    }
}

// MARK: - Extensions

// MARK: - Protocols Implemantations

// MARK: View Protocol

extension SplashPresenter: SplashPresenterViewProtocol {
    
    func checkNetworkState() {
        interactor.checkNetworkState()
    }
    
    func getLaunchText() {
        viewController.startLoading()
        interactor.fetchLaunchText()
    }
}

// MARK: Interactor Protocol

extension SplashPresenter: SplashPresenterInteractorProtocol {
    
    func showNetworkError() {
        
        DispatchQueue.main.async {
            let error = ErrorModel(genericErrorType: .reachability)
            _ = self.handleGenericError(errorModel: error, viewController: self.viewController)
        }
    }
    
    func showLaunchText(_ text: String?) {
        
        DispatchQueue.main.async {
            self.viewController.stopLoading()
            self.viewController.showLaunchText(text)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.viewController.showHomeScreen()
            }
        }
    }
}

// MARK: Delegate Protocol

