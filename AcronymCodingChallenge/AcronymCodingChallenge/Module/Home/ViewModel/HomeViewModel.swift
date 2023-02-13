//
//  HomeViewModel.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 10/02/23.
//

import Foundation

/// HomeViewModelProtocol
/// Contains methods which will be used to show data on UI
protocol HomeViewModelProtocol: ObservableObject {
    var networkService: NetworkServiceProtocol { get }
    var acromineModel: [AcromineModel] { get set }
    
    func getAcromine(sf: String, lf: String)
}

/// HomeViewModel
/// Class is responsible for all the buisness logic of Home View
final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Variables
    @Published var acromineModel: [AcromineModel] = []
    var networkService: NetworkServiceProtocol
    var completion: (([AcromineModel]?, ServerError) -> ())?
    
    //MARK: - Init
    init(acromineModel: [AcromineModel] = [],
         networkService: NetworkServiceProtocol = NetworkService()
    ) {
        self.acromineModel = acromineModel
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    /// Get data from cloud server
    func getAcromine(sf: String, lf: String = "") {
        if !sf.isEmpty {
            let param = RequestModel.AcromineInfo(sf: sf, lf: lf)
            Task {
                let result = await networkService.getAcromine(param: param)
                switch result {
                case .success(let model):
                    if let model {
                        self.acromineModel = model
                        
                        /// Send result to view with the help of completion block
                        if model.isEmpty {
                            completion?(model, ServerError.emptyData)
                        } else {
                            completion?(model, ServerError.none)
                        }
                    }
                case .failure(let error):
                    print(error)
                    completion?(nil, error)
                }
            }
        }
    }
}
