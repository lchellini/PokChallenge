//
//  UserModel.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 01/08/21.
//

import Foundation


struct PokDetailsModel: Decodable {
    var name: String
    var id: Int?
    var height = 0
    var weight = 0
    var baseExperience = 0
    var stats = [Stats]()
    var sprites = Sprites()
}


struct Stats: Decodable {
    struct Stat: Decodable {
        var name = ""
    }
    
    var baseStat = 0
    var stat: Stat
}


struct Sprites: Decodable {
    var backDefault = ""
    var backFemale: String?
    
    var backShiny: String?
    var backShinyFemale: String?
    
    var frontDefault = ""
    var frontFemale: String?
    
    var frontShiny: String?
    var frontShinyFemale: String?
    
    var other: Other?
    
    
    struct Other: Decodable {
        var officialArtwork:OfficialArtwork?
        
        private enum CodingKeys : String, CodingKey {
           case officialArtwork = "official-artwork"
       }
    }
    struct OfficialArtwork: Decodable {
        var frontDefault:String?
    }
}



