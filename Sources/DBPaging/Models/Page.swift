//
//  Page.swift
//  Page
//
//  Created by Robin Gurung on 25/08/2021.
//

import Foundation



public struct Page<Key: Equatable, Value> {
    
    public let request: PagingRequest<Key>
    
    public let values: [Value]
    
    public init(request: PagingRequest<Key>, values: [Value]) {
        self.request = request
        self.values = values
    }
}

public extension Page {
    /**
     A key identifies a page and its request.
     */
    var key: Key {
        request.key
    }
    
    /**
     A page is complete if it has as many values as requested (by the pageSize param of the request).
     */
    var isComplete: Bool {
        values.count == request.params.pageSize
    }
}
