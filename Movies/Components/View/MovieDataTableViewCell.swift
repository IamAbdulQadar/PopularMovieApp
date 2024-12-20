//
//  MovieDataTableViewCell.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import SDWebImage
import UIKit

/*
protocol MovieDataTableViewCellProtocol: NSObject {
    func getSelectedId(selectedID: Int) -> Void
}
*/

class MovieDataTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
//    weak var delegate: MovieDataTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(name: String, icon: String, lang: String, rating: Double, releaseDate: String) {
        nameLabel.text = name
        setIconImage(from: icon)
        languageLabel.text = "Language: " + lang
        ratingLabel.text = "Rating: " + String(rating)
        releaseDateLabel.text = "Release on: " + releaseDate
    }

    func setIconImage(from path: String) {
        let urlString = NetworkConstant.shared.imageBaseUrl + path
        setImage(for: icon, urlString: urlString)
    }

    private func setImage(for imageView: UIImageView, urlString: String) {
        if let imageUrl = URL(string: urlString) {
            imageView.sd_setImage(with: imageUrl, completed: nil)
        } else {
            imageView.image = UIImage(named: "movieIcon")
        }
    }
}

/*
extension MovieDataTableViewCell {
    @IBAction func nextButtonPressed() {
        delegate?.getSelectedId(selectedID: self.id)
    }
}
*/
