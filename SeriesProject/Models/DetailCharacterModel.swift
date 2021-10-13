//
//  DetailCharacterModel.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 13.10.2021.
//

import Foundation

// MARK: - DetailCharacterModel
struct DetailCharacterModel: Codable {
    var name: String?
    var birthday: String?
    var img: String?
    var nickName: String?
    var portrayed: String?
    var category: String?
    var occupation: [String]?
}
