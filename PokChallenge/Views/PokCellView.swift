//
//  PokCellView.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import Foundation
import UIKit


let pokCell_Identifier:String = "pokCell"


class PokCellView: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokImage: NetImageView!
    @IBOutlet weak var pokName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        
        self.containerView.withBorder(p_width: 1, p_radius: 40, p_color: Colors.pokCellBorder)
        self.containerView.withShadow(p_color: Colors.pokCellShadow, p_opacity: 1, p_offset: CGSize(width: 5, height: 6), p_radius: 3)
        
        self.pokName.textColor = Colors.pokCellText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
