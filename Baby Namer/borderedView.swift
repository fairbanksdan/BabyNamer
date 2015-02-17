//
//  borderedView.swift
//  Baby Namer
//
//  Created by Daniel Fairbanks on 2/16/15.
//  Copyright (c) 2015 Fairbanksdan. All rights reserved.
//

import UIKit

@IBDesignable class BorderedView: UIImageView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
        
    }
    
    @IBInspectable var borderColor: UIColor = .whiteColor() {
        didSet {
            self.layer.borderColor = borderColor.CGColor
        }
        
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSizeMake(0, 0) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .blackColor() {
        didSet {
            self.layer.shadowColor = shadowColor.CGColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
}
