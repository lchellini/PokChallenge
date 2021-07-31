//
//  Observable.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 31/07/21.
//

import Foundation

// Observable

class Observable<T> {
    var value: T? {
        didSet {
            self.listener?(value)
        }
    }
    init(_ p_value: T?) {
        self.value = p_value
    }
    
    //MARK: - Listener
    private var listener: ((T?) -> Void)?
    
    func bind(_ p_listener: @escaping (T?) -> Void) {
        p_listener(self.value)
        self.listener = p_listener
    }
}
