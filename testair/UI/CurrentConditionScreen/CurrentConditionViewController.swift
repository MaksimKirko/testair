//
//  CurrentWeatherConditionViewController.swift
//  testair
//
//  Created by m.kirko on 10/21/20.
//

import UIKit

class CurrentConditionViewController: UIViewController {
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityAndDayLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    @IBOutlet weak var conditionDescriptionLabel: UILabel!
    
    var condition: WeatherConditionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        
        if let condition = condition {
            temperatureLabel.text = String(condition.main.temp)
            cityAndDayLabel.text = "\(condition.cityName) / Sunday"
            minMaxTemperatureLabel.text = "\(condition.main.tempMin) / \(condition.main.tempMax)"
            conditionDescriptionLabel.text = condition.weather[0].description
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
        self.dismiss(animated: true, completion: nil)
    }
}
