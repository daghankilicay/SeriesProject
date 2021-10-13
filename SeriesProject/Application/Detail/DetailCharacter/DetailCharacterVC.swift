//
//  DetailCharacterVC.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 13.10.2021.
//

import UIKit

class DetailCharacterVC: UIViewController {
    var viewModel: DetailCharacterViewModel?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBirthDay: UILabel!
    @IBOutlet weak var lblHeroName: UILabel!
    @IBOutlet weak var lblNickName: UILabel!
    @IBOutlet weak var lblSeriesName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
    }

    private func setNavigation() {
        self.title = "Series Project"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"ALL", style:.plain, target:nil, action:nil)

    }

    private func setUI(){
        image.kf.setImage(with: URL(string: viewModel?.img ?? ""))
        lblName.text = viewModel?.portrayed ?? ""
        lblBirthDay.text = viewModel?.birthday ?? ""
        lblHeroName.text = viewModel?.name ?? ""
        lblNickName.text = viewModel?.nickName ?? ""
        lblSeriesName.text = viewModel?.category
    }
}
