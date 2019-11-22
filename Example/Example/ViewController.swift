//
//  ViewController.swift
//  Example
//
//  Created by admin on 11/22/19.
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
        otpView.otpTextFieldActiveBorderColor = UIColor.white
        otpView.otpTextFieldDefaultBorderColor = UIColor.white
        otpView.otpTextFieldFontColor = UIColor.white
        otpView.cursorColor = UIColor.white
        otpView.otpTextFieldBorderWidth = 2
        otpView.otpEnteredString = { pin in
            print("The entered pin is \(pin)")
        }
    }
    
    override func viewDidLayoutSubviews() {
         otpView.initializeUI()
    }


}

