//
//  DetailViewModel.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import Foundation

class DetailViewModel: BaseViewModel {
    var url: String?
    var name: String?
    var premiered: String?
    var image: String?
    var summary: String?
    
    init(model: DetailSeriesModel) {
        self.name = model.name
        self.url = model.url
        self.premiered = model.premiered
        self.image = model.image
        self.summary = model.summary
    }
}
