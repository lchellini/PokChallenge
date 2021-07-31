//
//  ViewController.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableV: UITableView!
    private let pokCell_Identifier = "pokCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initTable()
    }
    
    override func didReceiveMemoryWarning() {
        debugPrint("MEMORY WARNING")
    }
    
    
    // MARK: - Private methods
    
    
    private func initTable() {
        self.tableV.dataSource = self
        self.tableV.delegate = self
    }


}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokCell_Identifier) as! PokCellView
        cell.pokName.text = "\(indexPath.row)"
        cell.pokImage.image = UIImage.init(named: "waitingImage")
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
}
