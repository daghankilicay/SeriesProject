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
        self.layer.cornerRadius = 10
    }
    
    private func configureUI() {
        img.kf.setImage(with: URL(string: popularSeries?.image?.medium ?? ""))
        lblSeriesName.text = popularSeries?.name ?? ""
        lblSeriesPremiered.text = formatDate(date: popularSeries?.premiered)
        lblSeriesLanguage.text = popularSeries?.language ?? ""
    }
    
    private func formatDate(date: String?) -> String {
        guard let date = date else { return "" }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-mm-dd"
        guard let formattedDate = inputFormatter.date(from: date) else { return "" }
        inputFormatter.dateFormat = "dd-mm-yyyy"
        return inputFormatter.string(from: formattedDate)
    }
}
