//
//  ViewController.swift
//  testair
//
//  Created by Maksim Kirko on 10/19/20.
//

import UIKit
import WeatherService
import CitySearchScreen

public class CitySearchViewController: UIViewController, View {
    private let searchFieldsCornerRadius: CGFloat = 8.0
    
    @IBOutlet weak var citySearchTextField: TestairTextField!
    @IBOutlet weak var showCurrentConditionScreenButtonContainer: UIView!
    @IBOutlet weak var showCurrentConditionScreenImageView: UIImageView!
    
    public var presenter: Presenter?
    
    public var shouldOpenCurrentConditionImmediately = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    private func setupViews() {
        self.citySearchTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.citySearchTextField.layer.cornerRadius = searchFieldsCornerRadius
        self.citySearchTextField.attributedPlaceholder = NSAttributedString.themePurple(string: "ENTER CITY NAME")
        
        self.showCurrentConditionScreenButtonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.showCurrentConditionScreenButtonContainer.layer.cornerRadius = searchFieldsCornerRadius
        
        self.showCurrentConditionScreenButtonContainer.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(showWeatherScreen))
        )
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.checkForSavedCity()
    }
    
    @objc func showWeatherScreen() {
        guard let city = citySearchTextField.text, !city.isEmpty else {
            return
        }
        
        self.presenter?.getCurrentCondition(for: city)
    }
    
    public func showError(error: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: error,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
