//
//  StadiumTableViewCell.swift
//  Stadiums
//
//  Created by Ivan Sanchez on 9/3/23.
//

import UIKit
import Kingfisher

class StadiumTableViewCell: UITableViewCell {
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var geocoordinateLabel: UILabel!
    
    var stadium: Stadium? {
        didSet {
            guard let stadium = stadium else { return }
            nameLabel.text = stadium.title
            geocoordinateLabel.text = "Coordendas: \(stadium.geocoordinates)"
        
            if let imageUrl = URL(string: stadium.image) {
                previewImageView.kf.setImage(with: imageUrl)
            } else {
                previewImageView.image = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        previewImageView.layer.cornerRadius = 8
        previewImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
