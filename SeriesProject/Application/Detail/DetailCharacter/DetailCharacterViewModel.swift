//
//  DetailCharacterViewModel.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 13.10.2021.
//

import Foundation

class DetailCharacterViewModel: BaseViewModel {
    var name: String?
    var birthday: String?
    var img: String?
    var nickName: String?
    var portrayed: String?
    var category: String?
    var occupation: [String]?
    
    init(model: DetailCharacterModel) {
        self.name = model.name
        self.birthday = model.birthday
        self.img = model.img
        self.nickName = model.nickName
        self.portrayed = model.portrayed
        self.category = model.category
        self.occupation = model.occupation
    }
}
