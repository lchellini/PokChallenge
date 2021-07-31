//
//  UIView_ext.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import UIKit

extension UIView {
    
    func withBorder(p_width:CGFloat, p_radius:CGFloat, p_color:UIColor) {
        self.layer.borderWidth = p_width
        self.layer.cornerRadius = p_radius
        self.layer.borderColor = p_color.cgColor
    }
    
    
    func withShadow(p_color:UIColor, p_opacity:Float, p_offset:CGSize, p_radius:CGFloat) {
        self.layer.shadowColor = p_color.cgColor
        self.layer.shadowOpacity = p_opacity
        self.layer.shadowOffset = p_offset
        self.layer.shadowRadius = p_radius
    }
    
}
