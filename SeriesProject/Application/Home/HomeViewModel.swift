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

final class HomeViewModel {
    typealias SeriesResponseResult = Result<SeriesResponse,Error>
    let disposeBag = DisposeBag()
    let pageLoadingStatus = BehaviorRelay<SeriesResponseState>(value: SeriesResponseState.loading)
    let dayOfTheSeries = BehaviorRelay<DayOfTheSeries?>(value: nil)
    let popularSeries = BehaviorRelay<[PopularSeries]?>(value: nil)
    
    func pageOpened(){
        pageLoadingStatus.accept(.loading)
        fetchSeriesResponseData()
    }

    // MARK: - FetchSeriesResponseData
    private func fetchSeriesResponseData() {
        BlobAPI.fetch(endPoint: "jsonblob/887822236724248576") { [unowned self] (seriesResponse: SeriesResponseResult) in
            switch seriesResponse {
            case .success(let seriesResponse):
                self.popularSeries.accept(seriesResponse.popularSeries)
                self.dayOfTheSeries.accept(seriesResponse.dayOfTheSeries)
                self.pageLoadingStatus.accept(.success)
            case .failure(let error):
                self.pageLoadingStatus.accept(.error(error.localizedDescription))
            }
        }
    }

    func numberOfItems() -> Int {
        return 0
    }
}
