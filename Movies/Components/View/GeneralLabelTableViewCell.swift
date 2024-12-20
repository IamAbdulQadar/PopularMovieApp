//
//  GeneralLabelTableViewCell.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import UIKit

class GeneralLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configureCell(name: String) {
        nameLabel.text = name
    }
}
