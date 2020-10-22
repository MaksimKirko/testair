//
//  Presenter.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import Foundation
import WeatherService

public protocol Presenter: class {
    func getCurrentCondition(for city: String)
}

public class DefaultPresenter: Presenter {
    weak var view: View?
    let interactor: Interactor
    let router: Router
    
    public init(view: View, interactor: Interactor, router: Router) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    public func getCurrentCondition(for city: String) {
        self.interactor.getCurrentCondition(for: city) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.router.showCurrentConditionScreen()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showError(error: error)
                }
            }
        }
    }
}
