//
//  PagingRequest.swift
//  PagingRequest
//
//  Created by Robin Gurung on 24/08/2021.
//

import Foundation



public enum PagingRequest<Key: Equatable> {
    
    case refresh(PagingRequestParam<Key>)
    case prepend(PagingRequestParam<Key>)
    case append(PagingRequestParam<Key>)
    
    public var params: PagingRequestParam<Key> {
        
        switch self {
            
        case .refresh(let pagingRequestParam):
            
            return pagingRequestParam
            
        case .prepend(let pagingRequestParam):
            
            return pagingRequestParam
            
        case .append(let pagingRequestParam):
            
            return pagingRequestParam
        }
    }
    
    public var key: Key {
        
        params.pagingChain.key
    }
}

extension PagingRequest {
    
    public func equals(_ other: PagingRequest) -> Bool {
        
        switch (self, other) {
            
        case (let .refresh(lhs), let .refresh(rhs)):
            
            return lhs.equals(rhs)
            
        case (let .prepend(lhs), let .prepend(rhs)):
            
            return lhs.equals(rhs)
            
        case (let .append(lhs), let .append(rhs)):
            
            return lhs.equals(rhs)
        default:
            return false
        }
    }
}

public extension PagingRequest {
    
    var moc: NSManagedObjectContext? {
        
        params.userInfo?[CoreDataInterceptorUserInfoParams.moc] as? NSManagedObjectContext
    }
}


public typealias PagingRequestParamsUserInfo = [AnyHashable: Any?]?

public struct PagingRequestParam<Key: Equatable> {
    
    public let pagingChain: PagingChain<Key>
    
    public let pageSize: Int
    
    public let retryPolicy: RetryPolicy?
    
    public let userInfo: PagingRequestParamsUserInfo
    
    let timeStamp: TimeInterval
    
    public init(
        pagingChain: PagingChain<Key>,
        pageSize: Int,
        retryPolicy: RetryPolicy? = nil,
        userInfo: PagingRequestParamsUserInfo = nil) {
        
            self.pagingChain = pagingChain
            self.pageSize = pageSize
            self.retryPolicy = retryPolicy
            self.userInfo = userInfo
            
            timeStamp = NSDate().timeIntervalSince1970
    }
}

extension PagingRequestParam {
    
    public func equals(_ other: PagingRequestParam) -> Bool {
        
        pagingChain == other.pagingChain && pageSize == other.pageSize
    }
}
