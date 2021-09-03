//
//  PagingSource.swift
//  PagingSource
//
//  Created by Robin Gurung on 24/08/2021.
//

import Foundation
import Combine


public typealias PagingResultPublisher<Key: Equatable, Value> = AnyPublisher<Page<Key, Value>, Error>


public protocol PagingSource {
    
    associatedtype Key: Equatable // request key
    
    associatedtype Value  // model
    
    var refreshKey: Key { get }
    
    func pagingChain(for key: Key) -> PagingChain<Key>
    
    func fetch(request: PagingRequest<Key>) -> PagingResultPublisher<Key, Value>
}
