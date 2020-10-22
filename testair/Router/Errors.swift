//
//  Errors.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import Foundation

extension AppDelegate {
    enum Error: Swift.Error {
        
    }
}

extension CitySearchScreenRouter {
    enum Error: Swift.Error {
        case noInitialViewControllerFound
        case invalidTypeOfViewController(AnyClass, shouldBe: AnyClass)
    }
}

extension CurrentConditionScreenRouter {
    enum Error: Swift.Error {
        case noInitialViewControllerFound
        case invalidTypeOfViewController(AnyClass, shouldBe: AnyClass)
    }
}
