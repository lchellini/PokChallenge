//
//  PokCellView.swift
//  testMVVM
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import Foundation
import UIKit


let pokCell_Identifier:String = "pokCell"


class PokCellView: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokImage: UIImageView!
    @IBOutlet weak var pokName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
