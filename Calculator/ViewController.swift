//
//  ViewController.swift
//  Calculator
//
//  Created by USER on 09/09/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Declerations
    
    var clearDisplay = false
    var isValidPress = false
    var logicManager = LogicManager()
    var verticalStack = UIStackView()
    var displayLabel = UILabel()
    
    var firstColumFromTheLeftButtons = ["CE", "7", "4", "1", "0"]
    var secondColumFromTheLeftButtons = ["", "8", "5", "2", ""]
    var thirdColumFromTheLeftButtons = ["", "9", "6", "3", "."]
    var fourthColumFromTheLeftButtons = ["÷", "x", "-", "+", "="]
    
    // MARK: - Programmatic UI
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        setupAndAddStackView()
        setUpAndAddHorizontalStackView()
        
    }
    
    func setupAndAddStackView() {
        view.addSubview(verticalStack)
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 1
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    func setUpAndAddHorizontalStackView() {
        for i in 0...6 {
            
            let horizontalStackView          = UIStackView()
            horizontalStackView.axis         = .horizontal
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing      = 1
            verticalStack.addArrangedSubview(horizontalStackView)
            
            if i == 1 {
                // add display Label
                horizontalStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
                horizontalStackView.isLayoutMarginsRelativeArrangement = true
                addDisplayLabel(view: horizontalStackView)
                
                
            } else if i >= 2 {
                // add button
                addButtonToStackView(view: horizontalStackView, forRowAt: i)
            }
        }
    }
    
    func addDisplayLabel(view: UIStackView) {
        displayLabel.font = displayLabel.font.withSize(30)
        displayLabel.textAlignment = .right
        displayLabel.textColor = .blue
        displayLabel.text = ""
        view.addArrangedSubview(displayLabel)
    }
    
    func addButtonToStackView(view: UIStackView, forRowAt: Int) {
        
        
        let horizontalStackRow = forRowAt - 2
        
        
        
        
        for i in 0...3 {
            
            if let colums = Enumerations.Colums(rawValue: i) {
                
                let button = UIButton(type: .system)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemGray
                view.addArrangedSubview(button)
                
                switch colums {
                case .firstFromLeft:
                    button.setTitle(firstColumFromTheLeftButtons[horizontalStackRow], for: .normal)
                    
                    if horizontalStackRow == 0 {
                        
                        // add clear button
                        button.addTarget(self, action: #selector(clearClicked(sender:)), for: .touchUpInside)
                        
                    } else {
                        
                        // button clicked function
                        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
                    }
                    
                    
                case .secondFromLeft:
                    button.setTitle(secondColumFromTheLeftButtons[horizontalStackRow], for: .normal)
                    
                    if horizontalStackRow > 0 && horizontalStackRow < 4 {
                        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
                    }
                case .thirdFromLeft:
                    button.setTitle(thirdColumFromTheLeftButtons[horizontalStackRow], for: .normal)
                    
                    if horizontalStackRow > 0 {
                        
                        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
                        
                    } else if horizontalStackRow == 4 {
                        button.addTarget(self, action: #selector(decimalClicked(sender:)), for: .touchUpInside)
                    }
                    
                    
                case .fourthFromLeft:
                    button.setTitle(fourthColumFromTheLeftButtons[horizontalStackRow], for: .normal)
                    button.backgroundColor = .green
                    
                    if horizontalStackRow == 4 {
                        button.addTarget(self, action: #selector(equalsClicked(sender:)), for: .touchUpInside)
                    } else {
                        button.addTarget(self, action: #selector(operationClicked(sender:)), for: .touchUpInside)
                        
                        button.tag = 3 - horizontalStackRow
                        
                    }
                }
            }
        }
    }
    
    
    // MARK: - Objective C Functions
    
    
    @objc func equalsClicked(sender: UIButton) {
        
        isValidPress = true
        
        logicManager.lastNumber = logicManager.currentNumber
        
        if let result = logicManager.calculateAndReturn(operation: "equals") {
            
            displayLabel.text = result
        }
    }
    
    @objc func operationClicked(sender: UIButton) {
        
        clearDisplay  = true
        
        if isValidPress  == true {
            
            if logicManager.calculateArray.count == 1 {
                logicManager.calculateArray.append(Double(sender.tag))
            } else {
                logicManager.calculateArray.append(logicManager.currentNumber)
                logicManager.calculateArray.append(Double(sender.tag))
            }
            displayLabel.text = String(logicManager.calculateArray[0])
        }
        
        logicManager.lastOperation = Double(sender.tag)
        if let result = logicManager.calculateAndReturn(operation: "operation") {
            displayLabel.text = result
        }
        
        isValidPress = false
        
    }
    
    @objc func clearClicked(sender: UIButton) {
        
        clearDisplay = false
        isValidPress = false
        logicManager.Clear()
        displayLabel.text = ""
        
    }
    
    
    @objc func buttonClicked(sender: UIButton) {
        
        if logicManager.calculateArray.count == 1 {
            clearClicked(sender: sender)
        }
        
        
        isValidPress = true
        if clearDisplay == true {
            displayLabel.text = ""
            clearDisplay = false
        }
        
        displayLabel.text! += sender.currentTitle!
        logicManager.currentNumber = Double(displayLabel.text!)!
        
    }
    
    @objc func decimalClicked(sender: UIButton) {
        
        if !((displayLabel.text)?.contains("."))! {
            displayLabel.text! += "."
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
}
