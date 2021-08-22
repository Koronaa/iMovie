//
//  CharacterResponse.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation

struct CharacterResponse: Codable {
    let name:String
    let birthYear, gender: String


    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case gender
    }
}
