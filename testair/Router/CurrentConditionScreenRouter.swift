//
//  CurrentConditionScreenRouter.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import UIKit
import SettingsService
import WeatherService
import CurrentConditionScreen

class CurrentConditionScreenRouter: Router, CurrentConditionScreen.Router {
    typealias ViewController = CurrentConditionViewController
    
    public weak var viewController: ViewController?
    
    struct Services {
        struct External {
            var settingsService: SettingsService
            var weatherService: WeatherService
        }
        var external: External
    }
    
    private var services: Services
    
    private init(viewController: ViewController, services: Services) {
        self.viewController = viewController
        self.services = services
    }
    
    func showCitySearchScreen() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    public static func build(city: String, services: Services.External) throws -> CurrentConditionScreenRouter {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self))
            .instantiateViewController(withIdentifier: "currentConditionViewController")
        
        guard let currentConditionViewController = viewController as? ViewController else {
            throw Error.invalidTypeOfViewController(type(of: viewController), shouldBe: ViewController.self)
        }
        
        let services = Services(external: services)
        
        let interactor = DefaultInteractor(settingsService: services.external.settingsService,
                                           weatherService: services.external.weatherService)
        let router = CurrentConditionScreenRouter(viewController: currentConditionViewController, services: services)
        let presenter = DefaultPresenter(city: city,
                                         view: currentConditionViewController,
                                         interactor: interactor,
                                         router: router)
        
        currentConditionViewController.presenter = presenter
        
        return router
    }
}
