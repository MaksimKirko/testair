//
//  Router.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import UIKit

protocol Router: class {
    associatedtype ViewController: UIViewController
    
    var viewController: ViewController? { get }
}
