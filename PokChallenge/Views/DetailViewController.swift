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
    @IBOutlet weak var infoBGView: UIView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightField: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightField: UILabel!
    
    @IBOutlet var statsLabelCollection:[UILabel]!
    @IBOutlet var statsValueCollection:[UILabel]!
    
    @IBOutlet weak var spriteGallery: UICollectionView!
    
    
    var viewModel = PokViewModel()
    var spritesList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = self.viewModel.pokSelected?.value?.name.capitalized
        
        self.infoBGView.backgroundColor = UIColor.clear
        self.infoBGView.withBorder(p_width: 2, p_radius: 20, p_color: Colors.detailInfoView)
        
        self.initGallery()
        self.viewModelBind()
        self.loadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        debugPrint("MEMORY WARNING")
    }
    
    
    // MARK: - Private methods
    private func initGallery() {
        self.spriteGallery.dataSource = self
        self.spriteGallery.delegate = self
    }
    
    
    private func loadData() {
        guard let pok = viewModel.pokSelected?.value else {return}
        
        if pok.id != nil {
            self.spritesList = viewModel.getPokSprites()
            self.spriteGallery.reloadData()
            
            weightLabel.textColor = Colors.detailLabelColor
            weightLabel.font = Fonts.detailLabels
            weightLabel.text = NSLocalizedString("Detail.Weight", comment: "Peso")
            weightField.text = "\(Double(pok.weight)/10.0) kg"
            weightField.textColor = Colors.detailValueColor
            weightField.font = Fonts.detailValue
            
            heightLabel.textColor = Colors.detailLabelColor
            heightLabel.font = Fonts.detailLabels
            heightLabel.text = NSLocalizedString("Detail.Height", comment: "Altezza")
            heightField.text = "\(Double(pok.height)/10.0) m"
            heightField.textColor = Colors.detailValueColor
            heightField.font = Fonts.detailValue
            
            if let url = URL(string: (pok.sprites.other?.officialArtwork?.frontDefault)!) {
                pokImage.loadImage(fromURL: url, p_placeHolderImage: "waitingImage")
            } else {
                pokImage.image = UIImage.init(named: "waitingImage")
            }
            
            for i in 0..<statsLabelCollection.count {
                if( i < pok.stats.count ){
                    statsLabelCollection[i].text = NSLocalizedString("Detail.\(pok.stats[i].stat.name)", comment: "Stat value")
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


// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.spritesList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: spriteCell_Identifier, for: indexPath) as! SpriteCellView
        
        cell.spriteImage.loadImage(fromURL: URL(string: self.spritesList[indexPath.row])! , p_placeHolderImage: "waitingImage")
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalCellWidth = spriteCell_width * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = spriteCell_spaceBetween * (collectionView.numberOfItems(inSection: 0) - 1)
        
        if CGFloat(totalCellWidth + totalSpacingWidth) < collectionView.layer.frame.size.width {
            let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        }
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    }
}
