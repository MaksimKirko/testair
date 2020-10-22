//
//  Presenter.swift
//  testair
//
//  Created by m.kirko on 10/22/20.
//

import Foundation

protocol Presenter: class {
    func getCurrentCondition(for city: String)
}

class DefaultPresenter: Presenter {
    
    
    func getCurrentCondition(for city: String) {
        
    }
}
