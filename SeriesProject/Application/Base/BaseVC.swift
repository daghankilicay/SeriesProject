//
//  BaseVC.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit

// MARK: - BaseVC
class BaseVC: UIViewController {
    static var activityIndicator = UIActivityIndicatorView()

    func showProgress() {
        BaseVC.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let barButton = UIBarButtonItem(customView: BaseVC.activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        BaseVC.activityIndicator.startAnimating()
    }

    func hideProgress() {
        BaseVC.activityIndicator.stopAnimating()
    }
}
