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
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    // MARK: - Class methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /// Observe the acronym api call
        observedAcromynData()
        
        /// SetUp UI components
        setUpUIComponents()
    }
    
    // MARK: - Custom methods
    func setUpUIComponents() {
        activityIndicator.isHidden = true
    }
    
    /// Update UI after getting the response from server
    func updateUIAfterAPIResponse() {
        self.searchButton.isEnabled = true
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
    
    /// Observed method to observe the result after API call with the help of view model completion
    func observedAcromynData() {
        viewModel.completion = { [weak self] (acModel, error) in
            if let acModel, !acModel.isEmpty {
                print("Success")
                DispatchQueue.main.async {
                    self?.updateUIAfterAPIResponse()
                    
                    if let detailVC = self?.storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
                        detailVC.acromineModel = acModel
                        self?.present(detailVC, animated: true)
                    }
                }
            } else {
                print("Failure")
                DispatchQueue.main.async {
                    self?.updateUIAfterAPIResponse()
                    self?.showAlert(title: "Error!", message: error.message)
                }
            }
        }
    }
    
    /// Initiate get acromyn API call from view model
    func getAcromineData(sf: String) {
        viewModel.getAcromine(sf: sf, lf: "")
    }
    
    /// Show alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: - IBOutlet actions
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        if let text = acronymTextField.text {
            if !text.isEmpty {
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                searchButton.isEnabled = false
                
                getAcromineData(sf: text)
            } else {
                showAlert(title: "Alert", message: "Please enter the text first.")
            }
        }
    }
}

