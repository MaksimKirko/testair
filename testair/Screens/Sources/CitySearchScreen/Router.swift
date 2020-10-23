//
//  Router.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import Foundation

public protocol Router: class {
    func showCurrentConditionScreen(city: String, animated: Bool)
}
