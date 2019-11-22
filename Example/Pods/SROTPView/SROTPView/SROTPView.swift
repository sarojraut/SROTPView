//
//  SROTPView.swift
//  SROTPView
//
//  Created by admin on 11/20/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

public class SROTPView: UIView {
    
    enum KeyboardType: Int {
        case numeric
        case alphabet
        case alphaNumeric
    }
    
    public var otpTextFieldsCount: Int = 4
    
    var otpTextFieldInputType: KeyboardType = .numeric
    
    public var otpTextFieldFont: UIFont = UIFont.systemFont(ofSize: 20)
    
    public var otpTextFieldEntrySecureType: Bool = false
    
    public var otpFilledEntryDisplay: Bool = false
    
    public var shouldRequireCursor: Bool = true
    
    public var cursorColor: UIColor = UIColor.blue
    
    public var otpTextFieldSize: CGFloat = 26
    
    public var otpTextFieldSeparatorSpace: CGFloat = 37
    
    public var otpTextFieldBorderWidth: CGFloat = 2
    
    public var otpTextFieldActiveBorderWidth: CGFloat = 4
    
    public var otpTextFieldDefaultBackgroundColor: UIColor = UIColor.clear
    
    public var otpTextFieldEnteredBackgroundColor: UIColor = UIColor.clear
    
    public var otpTextFieldDefaultBorderColor: UIColor = UIColor.gray
    
    public var otpTextFieldActiveBorderColor: UIColor = UIColor.black
    
    public var otpTextFieldErrorBorderColor: UIColor?
    
    public var otpTextFieldFontColor: UIColor?
    
    var aciveTextField:SROTPTextField?
    
    fileprivate var secureEntryData = [String]()
    
    public var hasEnteredAllOTP = false
    
    public var otpEnteredString :((String)->())?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:Initialize UI
    public func initializeUI() {
        layer.masksToBounds = true
        layoutIfNeeded()
        if (CGFloat(otpTextFieldsCount - 1)*otpTextFieldSeparatorSpace + CGFloat(otpTextFieldsCount)*otpTextFieldSize) > self.bounds.size.width{
            self.otpTextFieldSeparatorSpace = (self.bounds.size.width - CGFloat(otpTextFieldsCount)*otpTextFieldSize) / (CGFloat(otpTextFieldsCount - 1))
        }
        initializeotpTextFields()
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        topView.backgroundColor = UIColor.clear
        self.addSubview(topView)
        aciveTextField = (viewWithTag(1) as? SROTPTextField)
        aciveTextField?.becomeFirstResponder()
        self.aciveTextField?.shapeLayer.fillColor = otpTextFieldDefaultBorderColor.cgColor
        self.aciveTextField?.shapeLayer.strokeColor = otpTextFieldDefaultBorderColor.cgColor
        self.aciveTextField?.shapeLayer.lineWidth = otpTextFieldBorderWidth
        self.aciveTextField = viewWithTag(1) as? SROTPTextField
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getResponder))
        tapGesture.numberOfTapsRequired = 1
        topView.isUserInteractionEnabled = true
        topView.addGestureRecognizer(tapGesture)
    }
    
    //MARK:Get Touch event when touch on view
    @objc func getResponder(){
        if hasEnteredAllOTP && aciveTextField?.tag != self.otpTextFieldsCount{
            (viewWithTag(self.otpTextFieldsCount) as? SROTPTextField)?.becomeFirstResponder()
        }else{
            aciveTextField?.becomeFirstResponder()
        }
        
    }
    
    //MARK:Initialuze textFields
    
    fileprivate func initializeotpTextFields() {
        secureEntryData.removeAll()
        
        for index in stride(from: 0, to: otpTextFieldsCount, by: 1) {
            let oldotpTextField = viewWithTag(index + 1) as? SROTPTextField
            oldotpTextField?.removeFromSuperview()
            
            let otpTextField = getotpTextField(forIndex: index)
            
            addSubview(otpTextField)
            
            secureEntryData.append("")
        }
    }
    
    //MARK:Get textFields
    
    fileprivate func getotpTextField(forIndex index: Int) -> SROTPTextField {
        let hasOddNumberOfFields = (otpTextFieldsCount % 2 == 1)
        var fieldFrame = CGRect(x: 0, y: 0, width: otpTextFieldSize, height: otpTextFieldSize)
        if hasOddNumberOfFields {
            fieldFrame.origin.x = bounds.size.width / 2 - (CGFloat(otpTextFieldsCount / 2 - index) * (otpTextFieldSize + otpTextFieldSeparatorSpace) + otpTextFieldSize / 2)
        }
        else {
            fieldFrame.origin.x = bounds.size.width / 2 - (CGFloat(otpTextFieldsCount / 2 - index) * otpTextFieldSize + CGFloat(otpTextFieldsCount / 2 - index - 1) * otpTextFieldSeparatorSpace + otpTextFieldSeparatorSpace / 2)
        }
        fieldFrame.origin.y = (bounds.size.height - otpTextFieldSize) / 2
        let otpTextField = SROTPTextField(frame: fieldFrame)
        otpTextField.delegate = self
        otpTextField.tag = index + 1
        otpTextField.font = otpTextFieldFont
        otpTextField.textColor = otpTextFieldFontColor
        switch otpTextFieldInputType {
        case .numeric:
            otpTextField.keyboardType = .numberPad
        case .alphabet:
            otpTextField.keyboardType = .alphabet
        case .alphaNumeric:
            otpTextField.keyboardType = .namePhonePad
        }
        otpTextField.borderColorOfTextField = otpTextFieldDefaultBorderColor
        otpTextField.borderWidthOfTextField = otpTextFieldBorderWidth
        if shouldRequireCursor {
            otpTextField.tintColor = cursorColor
        }
        else {
            otpTextField.tintColor = UIColor.clear
        }
        otpTextField.backgroundColor = otpTextFieldDefaultBackgroundColor
        otpTextField.initalizeUI()
        
        return otpTextField
    }
    
    //MARK:Calculate enteredString
    
    fileprivate func calculateEnteredOTPSTring(isDeleted: Bool) {
        if isDeleted {
            hasEnteredAllOTP = false
            for index in stride(from: 0, to: otpTextFieldsCount, by: 1) {
                var otpTextField = viewWithTag(index + 1) as? SROTPTextField
                
                if otpTextField == nil {
                    otpTextField = getotpTextField(forIndex: index)
                }
                
                let fieldBackgroundColor = (otpTextField?.text ?? "").isEmpty ? otpTextFieldDefaultBackgroundColor : otpTextFieldEnteredBackgroundColor
                let fieldBorderColor =  otpTextFieldDefaultBorderColor
                otpTextField?.shapeLayer.fillColor = fieldBackgroundColor.cgColor
                otpTextField?.shapeLayer.strokeColor = fieldBorderColor.cgColor
                otpTextField?.shapeLayer.lineWidth = otpTextFieldBorderWidth
            }
        }else {
            var enteredOTPString = ""
            
            for index in stride(from: 0, to: secureEntryData.count, by: 1) {
                if !secureEntryData[index].isEmpty {
                    enteredOTPString.append(secureEntryData[index])
                }
            }
            
            if enteredOTPString.count == otpTextFieldsCount {
                hasEnteredAllOTP = (enteredOTPString.count == otpTextFieldsCount)
                otpEnteredString?(enteredOTPString)
                let isValid =  (enteredOTPString.count == otpTextFieldsCount)
                
                for index in stride(from: 0, to: otpTextFieldsCount, by: 1) {
                    var otpTextField = viewWithTag(index + 1) as? SROTPTextField
                    
                    if otpTextField == nil {
                        otpTextField = getotpTextField(forIndex: index)
                    }
                    
                    if !isValid {
                        otpTextField?.layer.borderColor = otpTextFieldDefaultBorderColor.cgColor
                    }
                    else {
                        otpTextField?.layer.borderColor = otpTextFieldDefaultBorderColor.cgColor
                    }
                }
            }
        }
    }
}

extension SROTPView: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        (textField as? SROTPTextField)?.shapeLayer.fillColor = otpTextFieldActiveBorderColor.cgColor
        (textField as? SROTPTextField)?.shapeLayer.strokeColor = otpTextFieldActiveBorderColor.cgColor
        (textField as? SROTPTextField)?.shapeLayer.lineWidth = otpTextFieldActiveBorderWidth
        self.aciveTextField = textField as? SROTPTextField
        
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if !replacedText.isEmpty && otpTextFieldInputType == .alphabet && replacedText.rangeOfCharacter(from: .letters) == nil {
            (textField as? SROTPTextField)?.shapeLayer.fillColor = otpTextFieldActiveBorderColor.cgColor
            (textField as? SROTPTextField)?.shapeLayer.strokeColor = otpTextFieldActiveBorderColor.cgColor
            (textField as? SROTPTextField)?.shapeLayer.lineWidth = otpTextFieldActiveBorderWidth
            return false
        }
        
        if replacedText.count >= 1 {
            secureEntryData[textField.tag - 1] = string
            
            if otpFilledEntryDisplay {
                textField.text = " "
            }else {
                if otpTextFieldEntrySecureType {
                    textField.text = "*"
                }
                else {
                    textField.text = string
                }
            }
            
            
            (textField as! SROTPTextField).shapeLayer.fillColor = otpTextFieldDefaultBorderColor.cgColor
            (textField as! SROTPTextField).shapeLayer.strokeColor = otpTextFieldDefaultBorderColor.cgColor
            (textField as! SROTPTextField).shapeLayer.lineWidth = otpTextFieldBorderWidth
            
            let nextotpTextField = viewWithTag(textField.tag + 1)
            
            if let nextotpTextField = nextotpTextField as? SROTPTextField{
                nextotpTextField.becomeFirstResponder()
                self.aciveTextField = nextotpTextField
                nextotpTextField.shapeLayer.fillColor = otpTextFieldActiveBorderColor.cgColor
                nextotpTextField.shapeLayer.strokeColor = otpTextFieldActiveBorderColor.cgColor
                nextotpTextField.shapeLayer.lineWidth = otpTextFieldActiveBorderWidth
            }else {
                textField.resignFirstResponder()
                textField.backgroundColor = otpTextFieldEnteredBackgroundColor
                textField.layer.borderColor = otpTextFieldDefaultBorderColor.cgColor
            }
            
            calculateEnteredOTPSTring(isDeleted: false)
        }else {
            let currentText = textField.text ?? ""
            
            if textField.tag > 1 && currentText.isEmpty {
                if let prevotpTextField = viewWithTag(textField.tag - 1) as? SROTPTextField {
                    deleteText(in: prevotpTextField)
                    prevotpTextField.shapeLayer.fillColor = otpTextFieldActiveBorderColor.cgColor
                    prevotpTextField.shapeLayer.strokeColor = otpTextFieldActiveBorderColor.cgColor
                    prevotpTextField.shapeLayer.lineWidth = otpTextFieldActiveBorderWidth
                }
            } else {
                deleteText(in: textField)
                if textField.tag > 1 {
                    if let prevotpTextField = viewWithTag(textField.tag - 1) as? SROTPTextField {
                        prevotpTextField.becomeFirstResponder()
                        self.aciveTextField = prevotpTextField
                        prevotpTextField.shapeLayer.fillColor = otpTextFieldActiveBorderColor.cgColor
                        prevotpTextField.shapeLayer.strokeColor = otpTextFieldActiveBorderColor.cgColor
                        prevotpTextField.shapeLayer.lineWidth = otpTextFieldActiveBorderWidth
                    }
                }else{
                    (textField as? SROTPTextField)?.shapeLayer.fillColor = otpTextFieldActiveBorderColor.cgColor
                    (textField as? SROTPTextField)?.shapeLayer.strokeColor = otpTextFieldActiveBorderColor.cgColor
                    (textField as? SROTPTextField)?.shapeLayer.lineWidth = otpTextFieldActiveBorderWidth
                }
            }
        }
        
        return false
    }
    
    private func deleteText(in textField: UITextField) {
        secureEntryData[textField.tag - 1] = ""
        textField.text = ""
        textField.becomeFirstResponder()
        calculateEnteredOTPSTring(isDeleted: true)
    }
}
