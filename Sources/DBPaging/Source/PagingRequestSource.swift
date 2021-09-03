//
//  PagingRequestSource.swift
//  PagingRequestSource
//
//  Created by Robin Gurung on 24/08/2021.
//

import Foundation
import Combine


public struct PagingRequestSource<Key: Equatable> {
    
    public typealias Request = PagingRequest<Key>
    
    private let subject = PassthroughSubject<Request,Never>()
    
    public var publisher: AnyPublisher<Request,Never> {
        
        subject.eraseToAnyPublisher()
    }
    
    public func send(request: Request) {
        
        subject.send(request)
    }
}
