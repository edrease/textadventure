//
//  GlowEffect.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 9/18/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import UIKit

class GlowEffect {
    
    class func addToLabel(label: UILabel) {
        
        let color = label.textColor
        
        label.layer.shadowColor = color!.cgColor
        label.layer.shadowRadius = 5.0
        label.layer.shadowOpacity = 0.9
        label.layer.shadowOffset = CGSize.zero
        label.layer.masksToBounds = false
    }
    
    class func addToButton(button: UIButton) {
        
        let color = button.titleColor(for: .normal)
        
        button.titleLabel?.layer.shadowColor = color!.cgColor
        button.titleLabel?.layer.shadowRadius = 5.0
        button.titleLabel?.layer.shadowOpacity = 0.9
        button.titleLabel?.layer.shadowOffset = CGSize.zero
        button.titleLabel?.layer.masksToBounds = false
    }
    
    class func addToViewBorder(view: UIView, color: CGColor) {
        
        view.layer.shadowColor = color
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize.zero
        view.layer.masksToBounds = false
    }
    
    class func addToView(view: UIView) {
        
        let color = view.backgroundColor
        
        view.layer.shadowColor = color?.cgColor
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize.zero
        view.layer.masksToBounds = false
    }
}
