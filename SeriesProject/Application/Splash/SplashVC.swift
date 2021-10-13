//
//  SplashVC.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit
import Lottie

// MARK: - SplashVC
class SplashVC: UIViewController {
    
    private lazy var animationView: AnimationView = {
        let jsonName = "TheatreLottie"
        let animation = Animation.named(jsonName)
        let animationView = AnimationView(animation: animation)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLottie()
    }
    
    private func setLottie() {
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200)
        ])
        startAnimation()
    }

    private func startAnimation() {
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.goToHomePage()
        }
    }
    
    private func goToHomePage() {
        let homeVC = HomeVC()
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Zapfino", size: 15)!]
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        present(navigationController, animated: true)
    }
    
}
