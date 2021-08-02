//
//  PokViewModel.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import Foundation
import UIKit


class PokViewModel : NSObject {
    var poks: Observable<[PokDetailsModel]> = Observable([])
    var lastError: Observable<String> = Observable("")
    var pokSelected: Observable<PokDetailsModel>?
    
    var indexInfo: IndexModel?
    var loadCompleted: Bool = false
    
    
    // MARK: - Public methods
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
    
    
    func selectPok(_ p_pokIndex:Int, p_nav:UINavigationController?) {
        self.pokSelected = Observable(poks.value?[p_pokIndex])
        
        if let nav = p_nav {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC: DetailViewController = storyboard.instantiateViewController(withIdentifier: "pokDetailView") as! DetailViewController
            nextVC.viewModel = self
            nav.pushViewController(nextVC, animated: true)
        }
    }
    
    
    func getPokSprites() -> [String] {
        guard let sprites = self.pokSelected?.value?.sprites else {return [String]()}
        let spritesArray = [sprites.backDefault, sprites.frontDefault, sprites.backFemale, sprites.backShiny, sprites.backShinyFemale, sprites.frontDefault, sprites.frontFemale, sprites.frontShiny, sprites.frontShinyFemale]
        return spritesArray.compactMap{ $0 }
    }
    
    
    // MARK: - Private methods
    private func parseIndexData(_ data:Data?, errorString:String) {
        if( data != nil ){
            do {
                self.indexInfo = try JSONDecoder().decode(IndexModel.self, from: data!)
                
                self.poks.value?.append(contentsOf: (self.indexInfo?.results.compactMap({
                    PokDetailsModel(name: $0.name)
                }))!)
                self.loadCompleted = self.poks.value!.count >= 880 //== self.indexInfo?.count
                
                //Load details
                self.loadPokDetails(self.indexInfo!.results)
            } catch {
                self.lastError.value = "Errore caricamento dati: \(error)"
            }
        } else {
            if( !errorString.isEmpty ){
                self.lastError.value = errorString
            }
        }
    }
    
    
    private func loadPokDetails(_ p_pokList:[PokModel]) {
        p_pokList.forEach{
            pokAPI_loadData($0.url, p_completion: { data, errorString in
                if( data != nil ){
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        if let decoded = try? decoder.decode(PokDetailsModel.self, from: data!) {
                            guard let podID = decoded.id else {return}
                            if( podID <= self.poks.value!.count ){
                                self.poks.value![podID-1] = decoded
                            }
                        }
                    }
                } else {
                    if( !errorString.isEmpty ){
                        debugPrint("loadPokDetails", errorString)
                    }
                }
            })
        }
    }
}
