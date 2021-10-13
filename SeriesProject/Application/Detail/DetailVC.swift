//
//  DetailVC.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit
import WebKit


class DetailVC: UIViewController {
    var viewModel: DetailViewModel?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPremieered: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnURL: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
    }

    @IBAction func clickedButton(_ sender: Any) {
        if let url = URL(string: viewModel?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }

    private func setNavigation() {
        self.title = "Series Project"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"ALL", style:.plain, target:nil, action:nil)

    }

    private func setUI(){
        image.kf.setImage(with: URL(string: viewModel?.image ?? ""))
        lblName.text = viewModel?.name ?? ""
        lblPremieered.text = viewModel?.premiered ?? ""
        lblSummary.attributedText = viewModel?.summary?.htmlToAttributedString
    }
    
}
