//
//  ViewController.swift
//  Example
//
//  Created by admin on 11/21/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SROTPView

class ViewController: UIViewController {

    @IBOutlet weak var otpView: SROTPView! //dont use SROTPField use SROTPView
    
    var enteredOtp: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        otpView.otpTextFieldsCount = 4
        otpView.otpTextFieldDefaultBorderColor = UIColor.gray
        otpView.otpTextFieldBorderWidth = 2
        otpView.initializeUI()
        otpView.otpEnteredString = { pin in
            print("The entered pin is \(pin)")
        }
    }


}

