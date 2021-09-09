//
//  PagingInterceptor.swift
//  PagingInterceptor
//
//  Created by Robin Gurung on 24/08/2021.
//

import Foundation


public enum PagingInterceptResult<Key: Equatable, Value> {
    case proceed(PagingRequest<Key>, handleAfterwards: Bool)
    case complete(Page<Key, Value>)
}

open class PagingInterceptor<Key: Equatable, Value> {
    public init() { }
    
    open func intercept(request: PagingRequest<Key>) throws -> PagingInterceptResult<Key, Value> {
        fatalError()
    }
    
    open func handle(result page: Page<Key, Value>) { }
}
