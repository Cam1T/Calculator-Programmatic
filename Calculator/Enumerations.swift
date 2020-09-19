//
//  Enumerations.swift
//  Calculator
//
//  Created by USER on 09/09/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import Foundation

struct Enumerations {
    
    enum Operations: Int {
        case add = 0
        case subtract = 1
        case multiply = 2
        case divide = 3
    }
    
    enum Colums: Int {
        
        case firstFromLeft = 0
        case secondFromLeft = 1
        case thirdFromLeft = 2
        case fourthFromLeft = 3
    }
}
