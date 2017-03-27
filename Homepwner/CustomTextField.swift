//
//  CustomTextField.swift
//  Homepwner
//
//  Created by Alex Louzao on 3/26/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        layer.borderWidth = 0.0
        return true
    }
}
