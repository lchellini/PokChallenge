//
//  Colors_ext.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 01/08/21.
//

import Foundation
import UIKit


extension UIColor {
    class func withRGBA(p_red:Int, p_green:Int, p_blue:Int, p_alpha:CGFloat) -> UIColor {
        return UIColor(red: CGFloat(p_red)/255.0, green: CGFloat(p_green)/255.0, blue: CGFloat(p_blue)/255.0, alpha: p_alpha)
    }
}
