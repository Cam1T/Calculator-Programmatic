//
//  LogicManager.swift
//  Calculator
//
//  Created by USER on 09/09/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import Foundation

class LogicManager {
    
    var calculateArray = [Double]()
    var lastNumber = 0.0
    var lastOperation = 0.0
    var currentNumber = 0.0
    
    func Clear() {
        
        calculateArray = []
        lastNumber = 0.0
        lastOperation = 0.0
        currentNumber = 0.0
    }
    
    
    func calculateAndReturn(operation: String) -> String? {
        
        if operation == "operation" {
            if calculateArray.count >= 3 {
                let newValue = calculate(firstNumber: calculateArray[0], SecondNumber: calculateArray[2], operation: Int(calculateArray[1]))
                calculateArray.removeAll()
                calculateArray.append(newValue)
                calculateArray.append(lastOperation)
                
                return String(calculateArray[0])
            }
        } else if operation == "equals" {
            
            if calculateArray.count >= 1 {
                let newValue = calculate(firstNumber: calculateArray[0], SecondNumber: lastNumber, operation: Int(lastOperation))
                calculateArray.removeAll()
                calculateArray.append(newValue)
                
                
                return String(calculateArray[0])
            }
            
        }
        
        return nil
    }
    
    
    
    func calculate(firstNumber: Double, SecondNumber: Double, operation: Int) -> Double {
        var total = 0.0
        
        if let operations = Enumerations.Operations(rawValue: operation){
            switch operations {
            case .add:
                total = firstNumber + SecondNumber
            case .subtract:
                total = firstNumber - SecondNumber
            case .multiply:
                total = firstNumber * SecondNumber
            case .divide:
                total = firstNumber / SecondNumber
            
            default:
                print("")
            }}
        return Double(floor(1000*total)/1000)
    }
}
