//
//  CustomNavController.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 01/08/21.
//

import Foundation
import UIKit

class CustomNavController: UINavigationController {
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
       super.awakeFromNib()
        
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.barTintColor = Colors.navBarBackGround
        
        self.navigationBar.tintColor = Colors.main
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Fonts.main!]
        
        self.delegate = self
    }
}


extension CustomNavController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
    }
    
}
