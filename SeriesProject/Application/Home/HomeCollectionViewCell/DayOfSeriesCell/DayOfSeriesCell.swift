//
//  DayOfSeriesCell.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit
import Kingfisher

class DayOfSeriesCell: UICollectionViewCell {
    static let cellIdentifier = "DayOfSeriesCell"
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    var character: Character? {
        didSet {
            configureUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.cornerRadius = img.frame.height/2
        img.clipsToBounds = true
    }

    func configureUI() {
        self.img.kf.setImage(with: URL(string: character?.img ?? ""))
        
        lblName.text = character?.name ?? ""
        
        
        
    }
}
