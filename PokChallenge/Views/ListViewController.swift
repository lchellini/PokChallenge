//
//  ViewController.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableV: UITableView!
    
    private var viewModel = PokViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initTable()
        self.viewModelBind()
        self.getData()
    }
    
    override func didReceiveMemoryWarning() {
        debugPrint("MEMORY WARNING")
    }
    
    
    // MARK: - Private methods
    private func getData() {
        self.viewModel.loadPokIndex()
    }
    
    
    private func initTable() {
        self.tableV.separatorStyle = .none
        self.tableV.dataSource = self
        self.tableV.delegate = self
    }
    
    
    // MARK: - Binding
    private func viewModelBind() {
        self.viewModel.poks.bind{ [weak self] _ in
            self?.updateData()
        }
        
        self.viewModel.lastError.bind{ [weak self] _ in
            if( !((self?.viewModel.lastError.value!.isEmpty)!) ){
                DispatchQueue.main.async {
                    self?.showErrorAlert((self?.viewModel.lastError.value)!)
                }
            }
        }
    }
    
    
    // MARK: - Binding methods
    func updateData() {
        DispatchQueue.main.async {
            self.tableV.reloadData()
        }
    }
    
    
    func showErrorAlert(_ p_message:String) {
        let alert = UIAlertController(title: AppInfo.Names.appBundleName, message: p_message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.poks.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokCell_Identifier) as! PokCellView
        if let pok = viewModel.poks.value?[indexPath.row] {
            cell.pokName.text = "\(pok.name)"
            cell.pokImage.image = UIImage.init(named: "waitingImage")
        }
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
}
