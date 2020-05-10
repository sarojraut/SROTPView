//
//  SROTPField.swift
//  SROTPView
//
//  Created by admin on 11/20/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SROTPTextField: UITextField {
    var borderColorOfTextField: UIColor = UIColor.black
    var placeholderString: String = ""
    var borderWidthOfTextField: CGFloat = 2
    var shapeLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initalizeUI() {
     
        addBottomView()
        self.placeholder = placeholderString
        autocorrectionType = .no
        textAlignment = .center
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        
        _ = delegate?.textField?(self, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
    }
    
    
    fileprivate func addBottomView() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.size.height))
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        path.close()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = borderWidthOfTextField
        shapeLayer.fillColor = backgroundColor?.cgColor
        shapeLayer.strokeColor = borderColorOfTextField.cgColor
        
        layer.addSublayer(shapeLayer)
    }
}
