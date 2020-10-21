//
//  UIColor+Theme.swift
//  testair
//
//  Created by m.kirko on 10/21/20.
//

import UIKit

extension UIColor {
    open class var themePurple: UIColor {
        return UIColor(named: "themePurple")!
    }
}

extension NSAttributedString {
    static func themePurple(string: String) -> NSAttributedString {
        return NSAttributedString(
            string: string,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.themePurple]
        )
    }
}
