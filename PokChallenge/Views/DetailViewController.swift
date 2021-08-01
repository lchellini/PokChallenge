//
//  DetailViewController.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 01/08/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var viewModel = PokViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = self.viewModel.pokSelected?.value?.name
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    override func didReceiveMemoryWarning() {
        debugPrint("MEMORY WARNING")
    }


}
