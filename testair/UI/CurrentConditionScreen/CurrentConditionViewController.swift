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
    @IBOutlet weak var backgroundGradientView: GradientView!
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
        
        self.presenter?.getCondition()
    }
    
    private func setupViews() {
        self.backgroundGradientView.colors = [UIColor.themePurple,
                                              UIColor.themeBlue]
        
        self.backImageView.image = UIImage(named: "arrow")?.withTintColor(.white)
        self.backImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        self.backImageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(backButtonDidTap))
        )
    }
    
    @objc func backButtonDidTap() {
        self.presenter?.showCitySearchScreen()
    }
    
    public func showCondition(condition: WeatherConditionModel) {
        self.temperatureLabel.text = "\(String(format: "%.0f", condition.main.temp))°"
        self.cityAndDayLabel.text = "\(condition.city) / \(condition.date.dayOfWeek())"
        self.minMaxTemperatureLabel.text = "\(String(format: "%.0f", condition.main.tempMin))° / \(String(format: "%.0f", condition.main.tempMax))°"
        self.conditionDescriptionLabel.text = condition.weather[0].description.fromCapitalizedLetter()
    }
    
    public func showError(error: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: error,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
