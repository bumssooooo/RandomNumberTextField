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
    
    public override func layoutSubviews() {
        keyboardView?.shuffleNumbers()
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
        keyboardView?.shuffleNumbers()
    }
}

extension RandomNumberTextField: RandomNumberKeyboardDelegate {
    func outputData(_ num: Int?) {
        var newText = ""
        
        if let num = num {
            newText = (text ?? "") + num.toString
        } else {
            if let curText = text,
                curText != "" {
                newText = curText
                newText.removeLast()
            }
        }
        
        self.text = newText
    }
}
