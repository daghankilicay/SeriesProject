//
//  ViewController.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: BaseVC {
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
            dayOfSeriesCollectionView.decelerationRate = .fast
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 80, height: 100)
            layout.sectionInset = UIEdgeInsets.zero
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 5
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

            let yourWidth = screen().width * 0.46
            let yourHeight = screen().width * 0.80
            let size = CGSize(width: yourWidth, height: yourHeight)
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = size
            layout.sectionInset = UIEdgeInsets.zero
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 0
            popularSeriesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            popularSeriesCollectionView.collectionViewLayout = layout
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchSeriesResponseData()
        registerNib()
        bindStatus()
        self.title = "Series Project"
    }
    
    // MARK: - RegisterNib
    private func registerNib() {
        dayOfSeriesCollectionView
            .register(UINib(nibName: String(describing: DayOfSeriesCell.self), bundle: nil),
                      forCellWithReuseIdentifier: DayOfSeriesCell.cellIdentifier)
        popularSeriesCollectionView
            .register(UINib(nibName: String(describing: PopularSeriesCell.self), bundle: nil),
                      forCellWithReuseIdentifier: PopularSeriesCell.cellIdentifier)
    }
}

// MARK: - BindStatus
extension HomeVC {
    private func bindStatus() {
        viewModel.pageLoadingStatus
            .subscribe(onNext: { [weak self] status in
                switch status {
                case .loading:
                    self?.showProgress()
                    self?.popularSeriesCollectionView.isHidden = true
                    self?.dayOfSeriesCollectionView.isHidden = true
                case let .error(error):
                    print(error)
                case .success:
                    self?.hideProgress()
                    self?.popularSeriesCollectionView.isHidden = false
                    self?.dayOfSeriesCollectionView.isHidden = false
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
}

// MARK: - CollectionViewDelegateDatasource
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == popularSeriesCollectionView {
            let series = viewModel.popularSeries.value?[indexPath.row]
            
            let model = DetailViewModel(model: DetailSeriesModel(url: series?.url,
                                                                 name: series?.name,
                                                                 premiered: series?.premiered,
                                                                 image: series?.image?.medium,
                                                                 summary: series?.summary))
            let detailVC = DetailVC()
            detailVC.viewModel = model
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let characters = viewModel.dayOfTheSeries.value?.characters?[indexPath.row]
            let characterModel = DetailCharacterViewModel(model: DetailCharacterModel(name: characters?.name,
                                                                                      birthday: characters?.birthday,
                                                                                      img: characters?.img,
                                                                                      nickName: characters?.nickname,
                                                                                      portrayed: characters?.portrayed,
                                                                                      category: characters?.category,
                                                                                      occupation: characters?.occupation))
            let detailCharacterVC = DetailCharacterVC()
            detailCharacterVC.viewModel = characterModel
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(detailCharacterVC, animated: true)
            
        }

        
    }
}

