//
//  Observable.swift
//  CoreData-Sample
//
//  Created by Sajjad Sarkoobi on 1/26/22.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listner?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listner: ((T?) -> Void)?
    
    func bind( _ listner: @escaping ((T?) -> Void) ) {
        listner(value)
        self.listner = listner
    }
}
