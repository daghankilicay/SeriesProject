//
//  SeriesResponse.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import Foundation

// MARK: - SeriesResponse
struct SeriesResponse: Codable {
    let dayOfTheSeries: DayOfTheSeries?
    let popularSeries: [PopularSeries]?
}

// MARK: - DayOfTheSeries
struct DayOfTheSeries: Codable {
    let name: String?
    let characters: [Character]?
}

// MARK: - PopularSery
struct PopularSeries: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let officialSite: String?
    let weight: Int?
    let image: Image?
    let summary: String?
    let updated: Int?
}

// MARK: - Image
struct Image: Codable {
    let medium: String?
    let original: String?
}

// MARK: - Character
struct Character: Codable {
    let charID: Int?
    let name: String?
    let birthday: String?
    let occupation: [String]?
    let status: String?
    let img: String?
    let nickname: String?
    let portrayed: String?
    let category: String?
}
