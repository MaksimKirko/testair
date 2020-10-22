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
    
    open class var themeBlue: UIColor {
        return UIColor(named: "themeBlue")!
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

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func fromCapitalizedLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
