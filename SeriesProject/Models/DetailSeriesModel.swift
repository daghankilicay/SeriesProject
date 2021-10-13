//
//  DetailModel.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 13.10.2021.
//

import Foundation

// MARK: - DetailSeriesModel
struct DetailSeriesModel: Codable {
    var url: String?
    var name: String?
    var premiered: String?
    var image: String?
    var summary: String?
}
