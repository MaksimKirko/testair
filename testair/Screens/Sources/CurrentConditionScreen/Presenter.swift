//
//  File.swift
//  
//
//  Created by m.kirko on 10/22/20.
//

import Foundation
import WeatherService

public protocol Presenter: class {
    func getCondition(for city: String)
    func showCitySearchScreen()
}

public class DefaultPresenter: Presenter {
    weak var view: View?
    let interactor: Interactor
    let router: Router

    private var condition: WeatherConditionModel? {
        return self.interactor.condition
    }
    
    public init(view: View, interactor: Interactor, router: Router) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    public func getCondition(for city: String) {
        if let condition = condition {
            self.view?.showCondition(condition: condition)
        } else {
            self.interactor.getCurrentCondition(for: city) { result in
                switch result {
                case .success(let condition):
                    DispatchQueue.main.async {
                        self.view?.showCondition(condition: condition)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.view?.showError(error: error)
                    }
                }
            }
        }
    }
    
    public func showCitySearchScreen() {
        router.showCitySearchScreen()
    }
}
