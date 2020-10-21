//
//  ViewController.swift
//  testair
//
//  Created by Maksim Kirko on 10/19/20.
//

import UIKit

class CitySearchViewController: UIViewController {
    private let searchFieldsCornerRadius: CGFloat = 8.0
    
    @IBOutlet weak var citySearchTextField: TestairTextField!
    @IBOutlet weak var showCurrentConditionScreenButtonContainer: UIView!
    @IBOutlet weak var showCurrentConditionScreenImageView: UIImageView!
    
    private var weatherService: WeatherService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        
        self.weatherService = DefaultWeatherService(weatherClient: DefaultWeatherClient())
    }
    
    private func setupViews() {
        citySearchTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        citySearchTextField.layer.cornerRadius = searchFieldsCornerRadius
        citySearchTextField.attributedPlaceholder = NSAttributedString.themePurple(string: "ENTER CITY NAME")
        
        showCurrentConditionScreenButtonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        showCurrentConditionScreenButtonContainer.layer.cornerRadius = searchFieldsCornerRadius
        
        showCurrentConditionScreenButtonContainer.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(showWeatherScreen))
        )
    }
    
    @objc func showWeatherScreen() {
        guard let cityName = citySearchTextField.text, !cityName.isEmpty else {
            return
        }
        
        self.weatherService.getCurrentCondition(for: cityName) { result in
            switch result {
            case .success(let condition):
                DispatchQueue.main.async {
                    guard let currentConditionViewController = UIStoryboard.init(name: "Main", bundle: Bundle(for: CitySearchViewController.self))
                            .instantiateViewController(identifier: "currentConditionViewController") as? CurrentConditionViewController else {
                        return
                    }
                    
                    currentConditionViewController.condition = condition
                    self.present(currentConditionViewController, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
