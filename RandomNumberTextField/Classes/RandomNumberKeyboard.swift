//
//  RandomKeyboard.swift
//  RandomKeyboard
//
//  Created by 김범수 on 2022/07/13.
//

import UIKit

protocol RandomNumberKeyboardDelegate {
    func outputData(_ input: KeyboardIput)
}

enum KeyboardIput {
    enum Order {
        case delete, clear, complete
    }
    
    case number(Int)
    case order(Order)
}

class RandomNumberKeyboard: UIView {
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    private var allButtons: [UIButton] {
        return numberButtons + [deleteButton, clearButton, completeButton]
    }
    
    static let ideytifier = "RandomNumberKeyboard"
    private var numbers: [Int?] = []
    var delegate: RandomNumberKeyboardDelegate?
    
    internal func configure() {
        addTargetNumberButtons()
        setButtonsCornerRadius(4.0)
        shuffleNumberButtons()
    }
    
    internal func shuffleNumberButtons() {
        numbers = makeRandomNumbers()
        configureNumberButtons()
    }
}

// MARK: Configure Methods

private  extension RandomNumberKeyboard {
    // generate random numbers
    func makeRandomNumbers() -> [Int?] {
        var numbers: [Int?] = []
        (0..<numberButtons.count).forEach {
            $0 <= 9 ? numbers.append($0) : numbers.append(nil)
        }
        return numbers.shuffled()
    }
    
    // configure number buttons by random numbers
    func configureNumberButtons() {
        zip(numbers, numberButtons).forEach { number, button in
            guard let number = number else {
                button.setTitle("", for: .normal)
                button.isEnabled = false
                button.backgroundColor = .clear
                return
            }
            button.setTitle(number.toString, for: .normal)
            button.isEnabled = true
            button.backgroundColor = .white
        }
    }
    
    // add target number buttons
    func addTargetNumberButtons() {
        numberButtons.enumerated().forEach { index, button in
            button.tag = index
            button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        }
    }
}

// MARK: Attribute Methods

internal extension RandomNumberKeyboard {
    func setBackgroundColor(_ color: UIColor?) {
        backgroundColor = color
    }
    
    func setFont(_ font: UIFont) {
        allButtons.forEach { button in
            button.titleLabel?.font = font
        }
    }
    
    func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        allButtons.forEach { button in
            button.setTitleColor(color, for: state)
        }
        deleteButton.tintColor = color
    }

    private func setButtonsCornerRadius(_ cornerRadius: Double) {
        allButtons.forEach { button in
            button.layer.cornerRadius = cornerRadius
        }
    }
}

private extension RandomNumberKeyboard {
    @objc func numberButtonTapped(sender: UIButton) {
        let index = sender.tag
        guard numbers.count > index,
              let number = numbers[index] else {
            return
        }
        delegate?.outputData(KeyboardIput.number(number))
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.outputData(KeyboardIput.order(.delete))
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        delegate?.outputData(KeyboardIput.order(.clear))
    }
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.outputData(KeyboardIput.order(.complete))
    }
}

extension Int {
    var toString: String {
        String(self)
    }
}
