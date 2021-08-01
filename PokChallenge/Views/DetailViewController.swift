//
//  DetailViewController.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 01/08/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pokImage: NetImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightField: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightField: UILabel!
    
    @IBOutlet var statsLabelCollection:[UILabel]!
    @IBOutlet var statsValueCollection:[UILabel]!
    
    var viewModel = PokViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = self.viewModel.pokSelected?.value?.name.capitalized
        
        self.viewModelBind()
        self.loadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        debugPrint("MEMORY WARNING")
    }
    
    
    // MARK: - Private methods
    private func loadData() {
        guard let pok = viewModel.pokSelected?.value else {return}
        
        if pok.id != nil {
            weightLabel.textColor = Colors.detailLabelColor
            weightField.text = "\(Double(pok.weight)/10.0) kg"
            weightField.textColor = Colors.detailValueColor
            
            heightLabel.textColor = Colors.detailLabelColor
            heightField.text = "\(Double(pok.height)/10.0) m"
            heightField.textColor = Colors.detailValueColor
            
            if let url = URL(string: (pok.sprites.other?.officialArtwork?.frontDefault)!) {
                pokImage.loadImage(fromURL: url, p_placeHolderImage: "waitingImage")
            } else {
                pokImage.image = UIImage.init(named: "waitingImage")
            }
            
            for i in 0..<statsLabelCollection.count {
                if( i < pok.stats.count ){
                    statsLabelCollection[i].text = pok.stats[i].stat.name
                    statsLabelCollection[i].textColor = Colors.detailLabelColor
                    statsLabelCollection[i].font = Fonts.detailStatsLabel
                    
                    statsValueCollection[i].text = "\(pok.stats[i].baseStat)"
                    statsValueCollection[i].textColor = Colors.detailValueColor
                    statsValueCollection[i].font = Fonts.detailStatsValue
                } else {
                    statsLabelCollection[i].text = ""
                }
            }
        }
    }
    
    
    // MARK: - Binding
    private func viewModelBind() {
        self.viewModel.pokSelected?.bind{ [weak self] _ in
            self?.updateData()
        }
    }
    
    
    // MARK: - Binding methods
    func updateData() {
        DispatchQueue.main.async {
            self.loadData()
        }
    }


}
