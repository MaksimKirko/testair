//
//  TestairTextField.swift
//  testair
//
//  Created by m.kirko on 10/21/20.
//

import UIKit

class TestairTextField: UITextField {
    @IBInspectable var inset: CGFloat = 12
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupColors()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupColors()
    }
    
    private func setupColors() {
        self.tintColor = UIColor.themePurple
        self.textColor = UIColor.themePurple
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
