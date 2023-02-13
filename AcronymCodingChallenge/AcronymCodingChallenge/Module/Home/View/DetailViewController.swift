//
//  DetailViewController.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 10/02/23.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var acronymLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable
    var acromineModel: [AcromineModel] = []
    
    // MARK: - Class methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpTableViewDelegate()
        showUIWithData()
    }
    
    // MARK: - Custom methods
    func showUIWithData() {
        acronymLabel.text = "Abbreviation Sort Form :- \(acromineModel.first?.sf ?? "")"
    }
    
    func setUpTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String(describing: AcronymsTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AcronymsTableCell.self))
    }
}

// MARK: - TableView data source and delegate methods

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acromineModel.first?.lfs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AcronymsTableCell.self), for: indexPath) as? AcronymsTableCell else {
            return UITableViewCell()
        }
        
        /// Show data on cell
        if let data = acromineModel.first?.lfs?[indexPath.row] {
            cell.setUpDataOnCell(data: data)
        }
        
        return cell
    }
}
