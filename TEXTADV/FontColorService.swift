//
//  FontColorService.swift
//  TEXTADV
//
//  Created by Edrease Peshtaz on 9/27/16.
//  Copyright © 2016 mysterio group. All rights reserved.
//

import UIKit

class FontColorService {
    class func determineFontColor(inputString: UILabel) {
        
        let appleIIcolor = UIColor(red: 84/255, green: 194/255, blue: 113/255, alpha: 1)
        
        switch inputString.text!.components(separatedBy: " ").first! {
            
        case "HQ:":
            inputString.textColor = UIColor.white
        case "PRINCE:":
            inputString.textColor = UIColor.purple
        case "TECH:":
            inputString.textColor = UIColor.cyan
        case "SPECTRE:":
            inputString.textColor = UIColor.yellow
        default:
            inputString.textColor = appleIIcolor
        }
        
        GlowEffect.addToLabel(label: inputString)
    }
}
