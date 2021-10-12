//
//  HomeViewModel.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import Foundation
import RxSwift
import RxCocoa

enum SeriesResponseState {
    case loading
    case success
    case error(String)
}

final class HomeViewModel: BaseViewModel {
    typealias SeriesResponseResult = Result<SeriesResponse,Error>
    let disposeBag = DisposeBag()
    let pageLoadingStatus = BehaviorRelay<SeriesResponseState>(value: SeriesResponseState.loading)
    let dayOfTheSeries = BehaviorRelay<DayOfTheSeries?>(value: nil)
    let popularSeries = BehaviorRelay<[PopularSeries]?>(value: nil)
    
    func fetchCovidData() {
        self.pageLoadingStatus.accept(.loading)
        BlobAPI.fetch(endPoint: "jsonblob/887822236724248576") { [unowned self] (covidData: SeriesResponseResult) in
            switch covidData {
            case .success(let covidData):
                self.popularSeries.accept(covidData.popularSeries)
                self.dayOfTheSeries.accept(covidData.dayOfTheSeries)
                self.pageLoadingStatus.accept(.success)
            case .failure(let error):
                self.pageLoadingStatus.accept(.error(error.localizedDescription))
            }
        }
    }
    
    func pageOpened() {
    }
    
    func numberOfItems() -> Int {
//        return result?.count ?? 0
        return 0
    }
    
    func viewDidDisappear() {
//        coordinator?.didFinishListing()
    }
}
