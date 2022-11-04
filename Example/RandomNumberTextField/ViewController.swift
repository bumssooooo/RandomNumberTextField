//
//  ViewController.swift
//  RandomNumberTextField
//
//  Created by beomsoo0 on 10/31/2022.
//  Copyright (c) 2022 beomsoo0. All rights reserved.
//

import UIKit
import RandomNumberTextField

class ViewController: UIViewController {
    @IBOutlet weak var sbKeyboard: RandomNumberTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureCbKeyboard()
    }

    func configureCbKeyboard() {
        let cbKeyboard = RandomNumberTextField()
        cbKeyboard.backgroundColor = .blue
        view.addSubview(cbKeyboard)
        cbKeyboard.translatesAutoresizingMaskIntoConstraints = false
        cbKeyboard.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        cbKeyboard.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        cbKeyboard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cbKeyboard.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}


extension ViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

