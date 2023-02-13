//
//  Encodable+Utility.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 10/02/23.
//

import Foundation

extension Encodable {
    var asDictionary: [String: Any]? {
        guard
            let data = try? JSONEncoder().encode(self)
        else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap{ $0 as? [String: Any]}
    }
}
