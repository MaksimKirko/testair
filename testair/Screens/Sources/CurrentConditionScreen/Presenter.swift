//
//  File.swift
//  
//
//  Created by m.kirko on 10/22/20.
//

import Foundation
import WeatherService

public protocol Presenter: class {
    var condition: WeatherConditionModel? { get }
    func showCitySearchScreen()
}

public class DefaultPresenter: Presenter {
    weak var view: View?
    let interactor: Interactor
    let router: Router

    public var condition: WeatherConditionModel? {
        return self.interactor.condition
    }
    
    public init(view: View, interactor: Interactor, router: Router) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    public func showCitySearchScreen() {
        router.showCitySearchScreen()
    }
}
