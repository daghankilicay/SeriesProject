//
//  ViewController.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {
    var viewModel = HomeViewModel()
    @IBOutlet weak var dayOfSeriesCollectionView: UICollectionView! {
        didSet {
            dayOfSeriesCollectionView.isHidden = true
            viewModel.dayOfTheSeries
                .subscribeOn(MainScheduler.instance)
                .subscribe { [weak self] _ in
                    self?.dayOfSeriesCollectionView.reloadData()
                    
                }
                .disposed(by: viewModel.disposeBag)
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.sectionInset = UIEdgeInsets.zero
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
            dayOfSeriesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            dayOfSeriesCollectionView.collectionViewLayout = layout
        }
    }
    @IBOutlet weak var popularSeriesCollectionView: UICollectionView!{
        didSet {
            popularSeriesCollectionView.isHidden = true
            viewModel.popularSeries
                .subscribeOn(MainScheduler.instance)
                .subscribe { [weak self] _ in self?.popularSeriesCollectionView.reloadData() }
                .disposed(by: viewModel.disposeBag)
            
            
            
            let yourWidth = popularSeriesCollectionView.bounds.width/3
            let yourHeight = popularSeriesCollectionView.bounds.height/3
            let size = CGSize(width: yourWidth, height: yourHeight)
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = size
            layout.sectionInset = UIEdgeInsets.zero
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
            popularSeriesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            popularSeriesCollectionView.collectionViewLayout = layout
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCovidData()
        registerNib()
        bindStatus()
        // Do any additional setup after loading the view.
    }
    
    private func registerNib() {
        dayOfSeriesCollectionView
            .register(UINib(nibName: String(describing: DayOfSeriesCell.self), bundle: nil),
                      forCellWithReuseIdentifier: DayOfSeriesCell.cellIdentifier)
        popularSeriesCollectionView
            .register(UINib(nibName: String(describing: PopularSeriesCell.self), bundle: nil),
                      forCellWithReuseIdentifier: PopularSeriesCell.cellIdentifier)
    }
}

extension HomeVC {
    private func bindStatus() {
        viewModel.pageLoadingStatus
            .subscribe(onNext: { [weak self] status in
                switch status {
                case .loading:
                    self?.popularSeriesCollectionView.isHidden = true
                    self?.dayOfSeriesCollectionView.isHidden = true
                    print("")
                case let .error(error):
                    print(error)
                case .success:
                    self?.popularSeriesCollectionView.isHidden = false
                    self?.dayOfSeriesCollectionView.isHidden = false
                    print("")
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dayOfSeriesCollectionView {
            return viewModel.dayOfTheSeries.value?.characters?.count ?? 0
        } else if collectionView == popularSeriesCollectionView {
            return viewModel.popularSeries.value?.count ?? 0
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dayOfSeriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayOfSeriesCell", for: indexPath) as! DayOfSeriesCell
            cell.character = viewModel.dayOfTheSeries.value?.characters?[indexPath.row]
            return cell
        } else if collectionView == popularSeriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularSeriesCell", for: indexPath) as! PopularSeriesCell
            cell.popularSeries = viewModel.popularSeries.value?[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell.init()
        }
        
    }
}

