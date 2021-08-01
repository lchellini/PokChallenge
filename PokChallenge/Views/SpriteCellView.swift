//
//  SpriteCellView.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 01/08/21.
//

import Foundation
import UIKit


let spriteCell_Identifier:String = "spriteCell"
let spriteCell_width:Int = 60
let spriteCell_spaceBetween:Int = 0

class SpriteCellView: UICollectionViewCell {
    
    @IBOutlet weak var spriteImage: NetImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
