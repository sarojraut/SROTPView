//
//  SROTPField.swift
//  SROTPView
//
//  Created by admin on 11/20/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

class OTPTextField: UITextField {

    var previousTextField: OTPTextField?
    var nextTextField: OTPTextField?
    let border = UIView()

    override public func deleteBackward(){
        if text == "" {
            previousTextField?.becomeFirstResponder()
        }
    }

    func addborder(color:UIColor,height:CGFloat){
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - height, width: frame.size.width, height: height)
        self.addSubview(border)
    }

    func changeToActiveBorder(color:UIColor,height:CGFloat){
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - 4, width: frame.size.width, height: height)
    }

    func changeToErrorBorder(color:UIColor,height:CGFloat){
           border.backgroundColor = color
           border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
           border.frame = CGRect(x: 0, y: frame.size.height - height, width: frame.size.width, height: height)
       }


    func changeToInActiveBorder(color:UIColor,height:CGFloat){
            border.backgroundColor = color
            border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            border.frame = CGRect(x: 0, y: frame.size.height - height, width: frame.size.width, height: height)
        }
}

