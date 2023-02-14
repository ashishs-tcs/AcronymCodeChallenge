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
    
    // MARK: - Variables
    
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
    func setUpComponents() {
        activityIndicator.isHidden = true
        
        /// Initialize the debouncer with call back method and 1 second delay
        debouncer = Debouncer.init(delay: 1, callback: triggerDebouncerCallback)
    }
    
    /// Trigger API call after given time once user stops writting
    private func triggerDebouncerCallback() {
        if !textFieldValue.isEmpty {
            print("api call with sf - \(textFieldValue)")
            
            acronymTextField.isEnabled = false
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            getAcromineData(sf: textFieldValue)
        }
    }
    
    /// Initiate get acromyn API call from view model
    func getAcromineData(sf: String) {
        viewModel.getAcromine(sf: sf, lf: "")
    }
    
    /// Observed method to observe the result after API call with the help of view model completion
    func observedAcromynData() {
        viewModel.completion = { [weak self] (acModel, error) in
            if let acModel, !acModel.isEmpty {
                print("Success")
                DispatchQueue.main.async {
                    self?.updateUIAfterAPICall()
                    if let detailVC = self?.storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController {
                        detailVC.acromineModel = acModel
                        self?.present(detailVC, animated: true)
                    }
                }
            } else {
                print("Failure")
                DispatchQueue.main.async {
                    self?.updateUIAfterAPICall()
                    self?.showAlert(title: "Error!", message: error.message)
                }
            }
        }
    }
    
    func updateUIAfterAPICall() {
        self.acronymTextField.isEnabled = true
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
    
    /// Show alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: - IBOutlet actions
    @IBAction func textChanged(_ sender: Any) {
        textFieldValue = (sender as? UITextField)?.text ?? ""
    }
}

