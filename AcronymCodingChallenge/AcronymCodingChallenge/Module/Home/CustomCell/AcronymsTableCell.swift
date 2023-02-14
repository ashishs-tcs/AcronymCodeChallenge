//
//  AcronymsTableCell.swift
//  AcronymCodingChallengeTests
//
//  Created by a2404643 on 10/02/23.
//

import UIKit

class AcronymsTableCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var sfLabel: UILabel!
    @IBOutlet weak var freqLabel: UILabel!
    @IBOutlet weak var sinceLabel: UILabel!
    @IBOutlet weak var varsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Custom method
    /// Update the table cell with data
    func setUpDataOnCell(data: LongFormModel) {
        sfLabel.text = "\(Constant.longForm) - \(data.lf ?? "")"
        freqLabel.text = "\(Constant.frequency) - \(data.freq ?? 0)"
        sinceLabel.text = "\(Constant.since) - \(data.since ?? 0)"
        varsCountLabel.text = "\(Constant.variationObjects) - \(data.vars?.count ?? 0)"
    }
}
