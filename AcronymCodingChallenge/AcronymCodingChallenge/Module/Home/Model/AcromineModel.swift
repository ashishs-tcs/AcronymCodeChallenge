//
//  AcromineModel.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 10/02/23.
//

import Foundation

/// AcromineModel
/// Parse the Acromine API response with respetive keys-values
struct AcromineModel: Decodable {
    // MARK: - Variables
    
    /// - sf: `String` represents the Abbreviation.
    let sf: String?
    
    ///   - lfs: `LongFormModel` represents the array of LongFormModel.
    let lfs: [LongFormModel]?
    
    // MARK: - Init
    
    /// Initializer.
    /// - Parameters:
    ///   - sf: `String` represents the Abbreviation.
    ///   - lfs: `LongFormModel` represents the array of LongFormModel.
    init(sf: String? = nil,
         lfs: [LongFormModel]? = nil
    ){
        self.sf = sf
        self.lfs = lfs
    }
    
    enum CodingKeys: String, CodingKey {
        case sf = "sf"
        case lfs = "lfs"
    }
}

struct LongFormModel: Decodable {
    
    // MARK: - Variable
    
    ///  - lf: `String` representative form of the full form.
    let lf: String?
    
    ///  - freq: `Int` the number of occurrences of the definition in the corpus
    let freq: Int?
    
    ///  - since: `Int` the year when the definition appeared for the first time in the corpus
    let since: Int?
    
    ///  - vars: `[VarsModel]` an array of variation objects that gather surface expressions of the full form in the corpus
    let vars: [VarsModel]?
    
    // MARK: - Init
    
    /// Initializer.
    /// - Parameters:
    ///   - lf: `String` representative form of the full form.
    ///   - freq: `Int` the number of occurrences of the definition in the corpus
    ///   - since: `Int` the year when the definition appeared for the first time in the corpus
    ///   - vars: `[VarsModel]` an array of variation objects that gather surface expressions of the full form in the corpus
    init(lf: String? = nil,
         freq: Int? = nil,
         since: Int? = nil,
         vars: [VarsModel]? = nil
    ) {
        self.lf = lf
        self.freq = freq
        self.since = since
        self.vars = vars
    }
    
    enum CodingKeys: String, CodingKey {
        case lf = "lf"
        case freq = "freq"
        case since = "since"
        case vars = "vars"
    }
}

struct VarsModel: Decodable {
    
    // MARK: - Variables
    
    ///  - lf: `String` representative form of the full form.
    let lf: String?
    
    ///  - freq: `Int` the number of occurrences of the definition in the corpus
    let freq: Int?
    
    ///  - since: `Int` the year when the definition appeared for the first time in the corpus
    let since: Int?
    
    // MARK: - Init
    
    /// Initializer.
    /// - Parameters:
    ///   - lf: `String` representative form of the full form.
    ///   - freq: `Int` the number of occurrences of the definition in the corpus
    ///   - since: `Int` the year when the definition appeared for the first time in the corpus
    init(lf: String? = nil,
         freq: Int? = nil,
         since: Int? = nil
    ) {
        self.lf = lf
        self.freq = freq
        self.since = since
    }
    
    enum CodingKeys: String, CodingKey {
        case lf = "lf"
        case freq = "freq"
        case since = "since"
    }
}
