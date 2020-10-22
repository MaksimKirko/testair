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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
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
        guard let city = citySearchTextField.text, !city.isEmpty else {
            return
        }
        
        self.presenter?.getCurrentCondition(for: city)
    }
    
    public func showError(error: Error) {
        
    }
}
