//
//  Observable.swift
//  MVVM-Observables
//
//  Created by huy on 2023/06/25.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

class Box<T> {
    //1
    typealias Listener = (T) -> Void
    var listener: Listener?
    //2
    var value: T {
        didSet {
            listener?(value)
        }
    }
    //3
    init(_ value: T) {
        self.value = value
    }
    //4
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
