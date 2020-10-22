//
//  CurrentWeatherConditionViewController.swift
//  testair
//
//  Created by m.kirko on 10/21/20.
//

import UIKit
import WeatherService
import CurrentConditionScreen

class CurrentConditionViewController: UIViewController, View {
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityAndDayLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    @IBOutlet weak var conditionDescriptionLabel: UILabel!
    
    public var presenter: Presenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        
        if let condition = presenter?.condition {
            temperatureLabel.text = "\(String(format: "%.0f", condition.main.temp))°"
            cityAndDayLabel.text = "\(condition.cityName) / \(condition.date.dayOfWeek())"
            minMaxTemperatureLabel.text = "\(String(format: "%.0f", condition.main.tempMin))° / \(String(format: "%.0f", condition.main.tempMax))°"
            conditionDescriptionLabel.text = condition.weather[0].description.fromCapitalizedLetter()
        }
    }
    
    private func setupViews() {
        backImageView.image = UIImage(named: "arrow")?.withTintColor(.white)
        backImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        backImageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(backButtonDidTap))
        )
    }
    
    @objc func backButtonDidTap() {
        presenter?.showCitySearchScreen()
    }
    
    func showError(error: Error) {
        
    }
}
