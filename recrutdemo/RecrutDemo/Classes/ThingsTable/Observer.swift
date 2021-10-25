//
//  Observer.swift
//  RecrutDemo
//
//  Created by Shilpa S on 25/10/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import Foundation

class Observable<T> {
    var value : T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    init(_ value : T?) {
        self.value = value
    }
    
    private var listener : ((T?) -> Void)?
    
    func bind(_ listener : @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
