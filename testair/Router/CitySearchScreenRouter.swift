//
//  CitySearchScreenRouter.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import UIKit
import SettingsService
import WeatherService
import CitySearchScreen

class CitySearchScreenRouter: Router, CitySearchScreen.Router {
    typealias ViewController = CitySearchViewController
    
    public weak var viewController: ViewController?
    public weak var rootViewController: UINavigationController?
    
    struct Services {
        var settingsService: SettingsService
        var weatherService: WeatherService
    }
    
    private var services: Services
    
    private init(rootViewController: UINavigationController, viewController: ViewController, services: Services) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.services = services
    }
    
    func showCurrentConditionScreen(city: String, animated: Bool) {
        let services = CurrentConditionScreenRouter.Services.External(
            settingsService: self.services.settingsService,
            weatherService: self.services.weatherService
        )
        
        do {
            let router = try CurrentConditionScreenRouter.build(city: city, services: services)
            
            guard let currentConditionViewController = router.viewController else {
                return
            }
            
            self.viewController?.navigationController?.pushViewController(currentConditionViewController, animated: animated)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    public static func build() throws -> CitySearchScreenRouter {
        guard let viewController = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self))
                .instantiateInitialViewController() else {
            throw Error.noInitialViewControllerFound
        }
        
        guard let citySearchViewController = viewController as? ViewController else {
            throw Error.invalidTypeOfViewController(type(of: viewController), shouldBe: ViewController.self)
        }
        
        let rootViewController = UINavigationController(rootViewController: citySearchViewController)
        rootViewController.setNavigationBarHidden(true, animated: false)
        
        let settingsService = DefaultSettingsService()
        
        let weatherClient = DefaultWeatherClient()
        let weatherService = DefaultWeatherService(weatherClient: weatherClient)
        
        let services = Services(settingsService: settingsService,
                                weatherService: weatherService)
        
        let interactor = DefaultInteractor(settingsService: settingsService,
                                           weatherService: weatherService)
        let router = CitySearchScreenRouter(rootViewController: rootViewController,
                                            viewController: citySearchViewController,
                                            services: services)
        let presenter = DefaultPresenter(view: citySearchViewController, interactor: interactor, router: router)
        
        citySearchViewController.presenter = presenter
        
        return router
    }
}
