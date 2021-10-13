//
//  AlertHelper.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 13.10.2021.
//

import Foundation
import UIKit

class AlertHelper {
    static var app: AlertHelper = {
        return AlertHelper()

    }()

    func alertMessage(vc: UIViewController, title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            
        }
        alertVC.addAction(okAction)

//        let viewController = UIApplication.shared.windows.first!.rootViewController!
        vc.present(alertVC, animated: true, completion: nil)
    }
}
