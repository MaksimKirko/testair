//
//  CitySearchScreenRouter.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import UIKit
import WeatherService
import CitySearchScreen

class CitySearchScreenRouter: Router, CitySearchScreen.Router {
    typealias ViewController = CitySearchViewController
    
    public weak var viewController: ViewController?
    
    struct Services {
        var weatherService: WeatherService
    }
    
    private var services: Services
    
    private init(viewController: ViewController, services: Services) {
        self.viewController = viewController
        self.services = services
    }
    
    func showCurrentConditionScreen() {
        let services = CurrentConditionScreenRouter.Services.External(weatherService: self.services.weatherService)
        
        do {
            let router = try CurrentConditionScreenRouter.build(services: services)
            
            guard let currentConditionViewController = router.viewController else {
                return
            }
            
            self.viewController?.present(currentConditionViewController,
                                         animated: true,
                                         completion: nil)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    public static func build() throws -> CitySearchScreenRouter {
        guard let viewController = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self)).instantiateInitialViewController() else {
            throw Error.noInitialViewControllerFound
        }
        
        guard let citySearchViewController = viewController as? ViewController else {
            throw Error.invalidTypeOfViewController(type(of: viewController), shouldBe: ViewController.self)
        }
        
        let weatherClient = DefaultWeatherClient()
        let weatherService = DefaultWeatherService(weatherClient: weatherClient)
        
        let services = Services(weatherService: weatherService)
        
        let interactor = DefaultInteractor(weatherService: weatherService)
        let router = CitySearchScreenRouter(viewController: citySearchViewController, services: services)
        let presenter = DefaultPresenter(view: citySearchViewController, interactor: interactor, router: router)
        
        citySearchViewController.presenter = presenter
        
        return router
    }
}
