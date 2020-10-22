//
//  File.swift
//  
//
//  Created by m.kirko on 10/22/20.
//

import Foundation

public protocol View: class {
    func showError(error: Error)
}
