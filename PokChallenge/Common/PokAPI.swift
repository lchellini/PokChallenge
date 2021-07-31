//
//  PokAPI.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import Foundation


private let firstCallURL = "https://pokeapi.co/api/v2/pokemon/"


func pokAPI_loadFirstData(p_completion: @escaping (Data?, String) ->() ){
    pokAPI_loadData(firstCallURL, p_completion: p_completion)
}


func pokAPI_loadData(_ p_url:String, p_completion: @escaping (Data?, String) ->() ){
    
    guard let url = URL(string:p_url) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            p_completion(nil, "Connection error: \(httpStatus.statusCode)")
        } else {
            if let data = data {
                p_completion(data, "")
            } else {
                p_completion(nil, "Dati non corretti")
            }
        }
    }
    task.resume()
}
