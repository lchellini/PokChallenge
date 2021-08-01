//
//  IndexModel.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import Foundation


struct IndexModel: Decodable {
    let count: Int
    let next: String
    let results: [PokModel]
}
