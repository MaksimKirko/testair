//
//  ViewController.swift
//  testair
//
//  Created by Maksim Kirko on 10/19/20.
//

import UIKit

class CitySearchViewController: UIViewController {
    let searchFieldsCornerRadius: CGFloat = 8.0
    
    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var showWeatherScreenButtonContainer: UIView!
    @IBOutlet weak var showWeatherScreenImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    private func setupViews() {
        citySearchTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        citySearchTextField.layer.cornerRadius = searchFieldsCornerRadius
        
        showWeatherScreenButtonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        showWeatherScreenButtonContainer.layer.cornerRadius = searchFieldsCornerRadius
        
        showWeatherScreenButtonContainer.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(showWeatherScreen))
        )
    }
    
    @objc func showWeatherScreen() {
        
    }
}
