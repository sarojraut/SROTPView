//
//  SROTPView.swift
//  SROTPView
//
//  Created by admin on 11/20/19.
//  Copyright © 2019 admin. All rights reserved.
//
import Foundation
import UIKit

public enum SROTPType {
    case Rounded
    case Bordered
    case UnderLined
}

public class SROTPView: UIView,UITextFieldDelegate {
    
    
    var otpStackView = UIStackView()
    //Customise the OTPField here
    public var otpTextFieldsCount = 6{
        didSet{
            self.addOTPFields()
        }
    }
    var activeTextField:OTPTextField?
    public var otpType:SROTPType = .Bordered
    public var customFont: UIFont?
    
    var textFieldsCollection: [OTPTextField] = []
    public var showsWarningColor = false
    public var hasEnteredAllOTP = false
    public var space: CGFloat = 28
    public var size: CGFloat = 50
    public var otpTextFieldFontColor = UIColor.white
    public var otpTextFieldErrorColor = UIColor.red
    
    public var cornerRediusValue: CGFloat = 4
    public var activeHeight = 1
    public var inactiveHeight = 1
    public var secureEntry = false
    //Colors
    public var otpTextFieldDefaultBorderColor = UIColor.white
    
    public var textBackgroundFilledColor = UIColor.gray
    public var textBackgroundColor = UIColor.clear
    public var otpTextFieldActiveBorderColor = UIColor.white
    public var otpEnteredString :((String)->())?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    public func setUpOtpView(){
        self.addSubview(otpStackView)
        otpStackView.heightAnchor.constraint(equalToConstant: size).isActive = true
        otpStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        otpStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        otpStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.setupStackView()
        self.addOTPFields()
        let topView = UIView()
        topView.backgroundColor = UIColor.clear
        topView.isUserInteractionEnabled = true
        self.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getResponder))
        tapGesture.numberOfTapsRequired = 1
        topView.addGestureRecognizer(tapGesture)
    }
    
    public func initializeUI(){
        self.refreshView()
        
    }
    
    //MARK:Get Touch event when touch on view
    @objc func getResponder(){
        self.assignResponder()
    }
    
    public func set(warning:Bool){
        self.otpStackView.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: .curveLinear, animations: {
            self.transform = CGAffineTransform.identity
            self.setWarningColor(isWarningColor: true)
        }) { _ in
            self.otpStackView.transform = CGAffineTransform.identity
        }
        
    }
    
    
    //Customisation and setting stackView
    func setupStackView() {
        otpStackView.backgroundColor = .clear
        otpStackView.isUserInteractionEnabled = true
        otpStackView.translatesAutoresizingMaskIntoConstraints = false
        otpStackView.contentMode = .center
        otpStackView.distribution = .equalSpacing
        otpStackView.spacing = space
        if (CGFloat(otpTextFieldsCount - 1)*space + CGFloat(otpTextFieldsCount)*size) > otpStackView.bounds.size.width{
            otpStackView.spacing = (otpStackView.bounds.size.width - CGFloat(otpTextFieldsCount)*size) / (CGFloat(otpTextFieldsCount - 1))
        }
        
    }
    
    //Adding each OTPfield to stack view
    func addOTPFields() {
        self.textFieldsCollection = []
        for each in otpStackView.subviews{
            each.removeFromSuperview()
        }
        for index in 0..<otpTextFieldsCount{
            let field = OTPTextField()
            field.tag = index
            setupTextField(field)
            textFieldsCollection.append(field)
            //Adding a marker to previous field
            index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
            //Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
        }
        
        activeTextField = textFieldsCollection[0]
    }
    
    func assignResponder(){
        DispatchQueue.main.async {
            self.activeTextField?.becomeFirstResponder()
        }
    }
    
    //Customisation and setting OTPTextFields
    func setupTextField(_ textField: OTPTextField){
        switch otpType {
        case .Rounded:
            textField.layer.cornerRadius = self.size/2
            textField.clipsToBounds = true
        default:
            textField.layer.cornerRadius = cornerRediusValue
            textField.clipsToBounds = true

            break
        }
        textField.delegate = self
        textField.textContentType = .none
        //Adding constraints wrt to its parent i.e OTPStackView
        textField.translatesAutoresizingMaskIntoConstraints = false
        otpStackView.addArrangedSubview(textField)
        textField.centerYAnchor.constraint(equalTo: otpStackView.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: otpStackView.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: size).isActive = true
        if secureEntry{
            textField.isSecureTextEntry = true
        }else{
            textField.isSecureTextEntry = false
        }
        textField.backgroundColor = textBackgroundColor
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.customFont = customFont ?? UIFont.systemFont(ofSize: 24)
        textField.textColor = otpTextFieldFontColor
        textField.keyboardType = .numberPad
        textField.otpType = self.otpType
        textField.addborder(color: otpTextFieldDefaultBorderColor,height: CGFloat(inactiveHeight))
    }
    
    func refreshView(){
        for fields in textFieldsCollection{
            fields.text = ""
            hasEnteredAllOTP = false
            (otpEnteredString?(""))
        }
        DispatchQueue.main.async {
            self.textFieldsCollection[0].becomeFirstResponder()
        }
        activeTextField = textFieldsCollection[0]
    }
    
    //checks if all the OTPfields are filled
    func checkForValidity(){
        for fields in textFieldsCollection{
            if (fields.text == ""){
                hasEnteredAllOTP = false
                (otpEnteredString?(self.getOTP()))
                return
            }
        }
        hasEnteredAllOTP = true
        (otpEnteredString?(self.getOTP()))
    }
    
    //gives the OTP text
    func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        return OTP
    }
    
    //set isWarningColor true for using it as a warning color
    func setWarningColor(isWarningColor: Bool = false){
        if isWarningColor{
            for textField in textFieldsCollection{
                textField.changeToErrorBorder(color: otpTextFieldErrorColor, height: CGFloat(self.inactiveHeight))
            }
        }else{
            for textField in textFieldsCollection{
                textField.changeToInActiveBorder(color: otpTextFieldDefaultBorderColor,height:CGFloat(activeHeight))
            }
        }
        showsWarningColor = isWarningColor
    }
    
    
    //TextField related operations
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.backgroundColor = textBackgroundColor
        hasEnteredAllOTP = false
        otpEnteredString?(self.getOTP())
        if showsWarningColor {
            setWarningColor(isWarningColor: false)
            showsWarningColor = false
        }
        if let field = textField as? OTPTextField{
            field.changeToActiveBorder(color: otpTextFieldActiveBorderColor,height: CGFloat(activeHeight))
        }
    }
    
    public   func textFieldDidEndEditing(_ textField: UITextField) {
        if let field = textField as? OTPTextField{
            field.changeToInActiveBorder(color: otpTextFieldDefaultBorderColor,height:CGFloat(inactiveHeight))
        }
    }
    
    //switches between OTPTextfields
    public  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        guard let textField = textField as? OTPTextField else { return true }
        
        if !replacedText.isEmpty &&  replacedText.rangeOfCharacter(from: .decimalDigits) == nil {
            return false
        }
        
        if (range.length == 0){
            if  replacedText == ""{
                activeTextField?.backgroundColor = textBackgroundColor
                activeTextField = textFieldsCollection[0]
                activeTextField?.becomeFirstResponder()
                return false
            }
            if textField.nextTextField == nil {
                activeTextField = textField
                DispatchQueue.main.async {
                    textField.resignFirstResponder()
                }
            }else{
                textField.nextTextField?.becomeFirstResponder()
                activeTextField = textField.nextTextField
            }
            textField.text? = string
            if string != ""{
                textField.backgroundColor = textBackgroundFilledColor
            }else{
                textField.backgroundColor = textBackgroundColor
            }

            checkForValidity()
            return false
            
        }else if (range.length == 1) {
            textField.previousTextField?.becomeFirstResponder()
            if textField.previousTextField != nil{
                activeTextField = textField.previousTextField
            }
            checkForValidity()
            return false
        }
        return false
    }
    
}
