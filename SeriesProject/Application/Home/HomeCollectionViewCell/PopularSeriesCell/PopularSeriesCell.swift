//
//  PopularSeriesCell.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit

class PopularSeriesCell: UICollectionViewCell {
    static let cellIdentifier = "PopularSeriesCell"
    @IBOutlet weak var img: UIImageView!
    @IBOutlet private weak var lblSeriesName: UILabel!
    @IBOutlet private weak var lblSeriesPremiered: UILabel!
    @IBOutlet private weak var lblSeriesLanguage: UILabel!
    var popularSeries: PopularSeries? {
        didSet {
            configureUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func configureUI() {
        img.kf.setImage(with: URL(string: popularSeries?.image?.medium ?? ""))
        lblSeriesName.text = popularSeries?.name ?? ""
        lblSeriesPremiered.text = popularSeries?.premiered ?? ""
        lblSeriesLanguage.text = popularSeries?.language ?? ""
        
    }
}
