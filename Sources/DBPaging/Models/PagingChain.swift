//
//  PagingChain.swift
//  PagingChain
//
//  Created by Robin Gurung on 24/08/2021.
//

import Foundation


public struct PagingChain<Key: Equatable>: Equatable {
    
    public let key: Key
    public let prevKey: Key?
    public let nextKey: Key?
    
    public init(key: Key, prevKey: Key?, nextKey: Key?) {
        
        self.key = key
        self.prevKey = prevKey
        self.nextKey = nextKey
    }
    
    
}
