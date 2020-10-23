//
//  GradientView.swift
//  testair
//
//  Created by m.kirko on 10/23/20.
//

import UIKit

class GradientView: UIView {
    enum GradientDirection {
        case horizontal, vertical
        
        var startPoint: CGPoint {
            switch self {
            case .horizontal:
                return CGPoint(x: 0.0, y: 0.5)
            case .vertical:
                return CGPoint(x: 0.5, y: 1.0)
            }
        }
        var endPoint: CGPoint {
            switch self {
            case .horizontal:
                return CGPoint(x: 1.0, y: 0.5)
            case .vertical:
                return CGPoint(x: 0.5, y: 0.0)
            }
        }
    }
    
    private var gradientDirection: GradientDirection = .vertical
    private var locations: [NSNumber]?
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        guard let layer = self.layer as? CAGradientLayer else {
            return CAGradientLayer()
        }
        return layer
    }
    
    var colors: [UIColor] = [] {
        didSet {
            self.updateGradientLayer(direction: self.gradientDirection)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, colors: [UIColor], direction: GradientDirection, locations: [NSNumber]? = nil) {
        super.init(frame: frame)
        assert(locations == nil || locations?.count == colors.count,
               "Number of stop points in locations should match number of colors")
        self.colors = colors
        self.gradientDirection = direction
        self.locations = locations
        self.updateGradientLayer(direction: self.gradientDirection)
    }
    
    private func updateGradientLayer(direction: GradientDirection) {
        self.gradientLayer.colors = self.colors.map({ $0.cgColor })
        self.gradientLayer.startPoint = direction.startPoint
        self.gradientLayer.endPoint = direction.endPoint
        self.gradientLayer.locations = locations
    }
}
