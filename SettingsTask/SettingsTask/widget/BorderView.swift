//
//  BorderView.swift
//  SettingsTask
//
//  Created by Romana on 7/11/22.
//

import UIKit

@IBDesignable class BorderView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 1.0 { didSet{ updateUI() } }
    @IBInspectable var corner: CGFloat = 5.0 { didSet{ updateUI() } }
    @IBInspectable var bgColor: UIColor = UIColor.white { didSet{ updateUI() } }
    @IBInspectable var borderColor: UIColor = UIColor(red: 0.95, green: 0.95, blue: 1.00, alpha: 1.00) { didSet{ updateUI() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateUI()
    }
    
    func updateUI() {
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        backgroundColor = bgColor
        layer.cornerRadius = corner
        
        setNeedsDisplay()
    }
    
}
