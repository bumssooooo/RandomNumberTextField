//
//  RandomKeyboard.swift
//  RandomKeyboard
//
//  Created by 김범수 on 2022/07/13.
//

import UIKit

protocol RandomNumberKeyboardDelegate {
    func outputData(_ num: Int?)
}

class RandomNumberKeyboard: UIView {
    @IBOutlet var oneButton: UIButton!
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    @IBOutlet var fiveButton: UIButton!
    @IBOutlet var sixButton: UIButton!
    @IBOutlet var sevenButton: UIButton!
    @IBOutlet var eightButton: UIButton!
    @IBOutlet var nineButton: UIButton!
    @IBOutlet var zeroButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    
    static let ideytifier = "RandomNumberKeyboard"
    private var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var delegate: RandomNumberKeyboardDelegate?
 
    internal func configure() {
        setBackgroundColor(.black)
        setFont(UIFont.systemFont(ofSize: 24.0, weight: .bold))
        setTitleColor(.white, for: .normal)
        shuffleNumbers()
    }
}

internal extension RandomNumberKeyboard {
    func setBackgroundColor(_ color: UIColor?) {
        backgroundColor = color
    }
    
    func setFont(_ font: UIFont) {
        [
            zeroButton,
            oneButton,
            twoButton,
            threeButton,
            fourButton,
            fiveButton,
            sixButton,
            sevenButton,
            eightButton,
            nineButton,
        ].enumerated().forEach { idx, button in
            button?.titleLabel?.font = font
        }
    }
    
    func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        [
            zeroButton,
            oneButton,
            twoButton,
            threeButton,
            fourButton,
            fiveButton,
            sixButton,
            sevenButton,
            eightButton,
            nineButton,
        ].enumerated().forEach { idx, button in
            button?.setTitleColor(color, for: state)
        }
        deleteButton.tintColor = color
    }
    
    func shuffleNumbers() {
        numbers = numbers.shuffled()
        
        [
            zeroButton,
            oneButton,
            twoButton,
            threeButton,
            fourButton,
            fiveButton,
            sixButton,
            sevenButton,
            eightButton,
            nineButton,
        ].enumerated().forEach { idx, button in
            button?.setTitle(numbers[idx].toString, for: .normal)
        }
    }
}

private extension RandomNumberKeyboard {
    @IBAction func oneButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[1])
    }
    @IBAction func twoButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[2])
    }
    @IBAction func threeButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[3])
    }
    @IBAction func fourButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[4])
    }
    @IBAction func fiveButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[5])
    }
    @IBAction func sixButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[6])
    }
    @IBAction func sevenButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[7])
    }
    @IBAction func eightButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[8])
    }
    @IBAction func nineButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[9])
    }
    @IBAction func zeroButtonTapped(_ sender: Any) {
        delegate?.outputData(numbers[0])
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.outputData(nil)
    }
}

extension Int {
    var toString: String {
        String(self)
    }
}
