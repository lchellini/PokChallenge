//
//  PokViewModel.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import Foundation


class PokViewModel : NSObject {
    var poks: Observable<[PokModel]> = Observable([])
    var lastError: Observable<String> = Observable("")
    
    var indexInfo: IndexModel?
    var loadCompleted: Bool = false
    
    
    func loadPokIndex() {
        if( indexInfo == nil ){
            pokAPI_loadFirstData(p_completion: { data, errorString in
                self.parseIndexData(data, errorString: errorString)
            })
        } else {
            pokAPI_loadData(indexInfo!.next, p_completion: { data, errorString in
                self.parseIndexData(data, errorString: errorString)
            })
        }
    }
    
    private func parseIndexData(_ data:Data?, errorString:String) {
        if( data != nil ){
            do {
                self.indexInfo = try JSONDecoder().decode(IndexModel.self, from: data!)
                
                self.poks.value?.append(contentsOf: (self.indexInfo?.results.compactMap({
                    PokModel(name: $0.name.capitalized, url: $0.url)
                }))!)
            } catch {
                self.lastError.value = "Errore caricamento dati: \(error)"
            }
        } else {
            if( !errorString.isEmpty ){
                self.lastError.value = errorString
            }
        }
    }
}
