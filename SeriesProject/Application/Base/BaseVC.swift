//
//  BaseVC.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit

// MARK: - BaseVC
class BaseVC: UIViewController {
    var progress : ProgressView?

    func showProgress(){
        self.progress = ProgressView.showProgress()
    }
    
    func hideProgress() {
        self.progress?.removeFromSuperview()
    }
}
