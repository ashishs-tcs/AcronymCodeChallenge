//
//  HomeViewController.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 09/02/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var acronymTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyDataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    /// Initialize view model
    lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    private var debouncer: Debouncer!
    
    private var textFieldValue = "" {
        didSet {
            debouncer.call()
        }
    }
    
    // MARK: - Class methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /// Observe the acronym api call
        observedAcromynData()
        
        /// SetUp UI components
        setUpComponents()
    }
    
    // MARK: - Custom methods
    /// Setup components when view did load
    func setUpComponents() {
        activityIndicator.isHidden = true
        emptyDataLabel.isHidden = true
        
        /// Setup tableview delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        /// Register custom table view cell to show data
        tableView.register(UINib(nibName: String(describing: AcronymsTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AcronymsTableCell.self))
        tableView.isHidden = true
        
        /// Initialize the debouncer with call back method and 1 second delay
        debouncer = Debouncer.init(delay: 1, callback: triggerDebouncerCallback)
    }
    
    /// Trigger API call after given time once user stops writting
    private func triggerDebouncerCallback() {
        if !textFieldValue.isEmpty {
            /// When initiate API call disable the text field
            acronymTextField.isEnabled = false
            
            /// When initiate API call show activity indicator
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            /// Hide empty data message label
            emptyDataLabel.isHidden = true
            
            /// Hide table view while calling an API
            tableView.isHidden = true
            
            /// API Call method
            getAcromineData(sf: textFieldValue)
        }
    }
    
    /// Initiate get acromyn API call from view model
    func getAcromineData(sf: String) {
        viewModel.getAcromine(sf: sf, lf: "")
    }
    
    /// Observed method to observe the result after API call with the help of view model completion
    func observedAcromynData() {
        viewModel.completion = { [weak self] (acromineModel, error) in
            if let acromineModel, !acromineModel.isEmpty {
                /// API Success
                /// Reload the tableview to load the data
                DispatchQueue.main.async {
                    self?.updateUIAfterAPICall()
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                }
            } else {
                /// API Failure
                /// If no data found after API call.
                DispatchQueue.main.async {
                    self?.updateUIAfterAPICall()
                    self?.tableView.isHidden = true
                    
                    self?.emptyDataLabel.isHidden = false
                    self?.emptyDataLabel.text = error.message
                }
            }
        }
    }
    
    /// Update the UI components after the API response
    func updateUIAfterAPICall() {
        /// Enable text filed for update
        self.acronymTextField.isEnabled = true
        
        /// Hide activity indicator
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: - IBOutlet actions
    @IBAction func textChanged(_ sender: Any) {
        textFieldValue = (sender as? UITextField)?.text ?? ""
    }
}

// MARK: - TableView data source and delegate methods

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Get the acromine  data count from view model acromine model
        return viewModel.acromineModel.first?.lfs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AcronymsTableCell.self), for: indexPath) as? AcronymsTableCell else {
            return UITableViewCell()
        }
        
        /// Render data on tableview cell
        if let data = viewModel.acromineModel.first?.lfs?[indexPath.row] {
            cell.setUpDataOnCell(data: data)
        }
        
        return cell
    }
}
