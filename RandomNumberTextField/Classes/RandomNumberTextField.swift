//
//  RandomNumberTextField.swift
//  RandomKeyboard
//
//  Created by 김범수 on 2022/07/13.
//

import UIKit

public class RandomNumberTextField: UITextField {
    private var keyboardView: RandomNumberKeyboard?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureKeyboardView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureKeyboardView()
    }
    
    override public func layoutSubviews() {
        configureKeyboardView()
    }

    private func configureKeyboardView() {
        guard let keyboardView = loadViewFromNib(nib: RandomNumberKeyboard.ideytifier) as? RandomNumberKeyboard else { return
        }
        keyboardView.configure()
        self.keyboardView = keyboardView
        inputView = keyboardView
        keyboardView.delegate = self
    }

    private func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

public extension RandomNumberTextField {
    func setKeyboardBackgroundColor(_ color: UIColor?) {
        keyboardView?.setBackgroundColor(color)
    }
    
    func setKeyboardFont(_ font: UIFont) {
        keyboardView?.setFont(font)
    }
    
    func setKeyboardTitleColor(_ color: UIColor?, for state: UIControl.State) {
        keyboardView?.setTitleColor(color, for: state)
    }
    
    func shuffleKeyboardNumbers() {
        // keyboardView?.shuffleNumbers()
    }
}

extension RandomNumberTextField: RandomNumberKeyboardDelegate {
    func outputData(_ input: KeyboardIput) {
        switch input {
        case .number(let number):
            numberHandler(number)
        case .order(let order):
            orderHandler(order)
        }
    }
    
    private func numberHandler(_ number: Int) {
        text = (text ?? "") + number.toString
    }
    
    private func orderHandler(_ order: KeyboardIput.Order) {
        switch order {
        case .delete:
            text?.popLast()
        case .clear:
            text?.removeAll()
        case .complete:
            resignFirstResponder()
        }
    }
}
