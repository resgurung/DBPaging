//
//  RetryPolicy.swift
//  RetryPolicy
//
//  Created by Robin Gurung on 24/08/2021.
//

import Foundation


public struct RetryPolicy {
    
    public let maxRetries: Int
    
    public let shouldRetry: (Error) -> Bool
    
    public init(maxRetries: Int,
                shouldRetry: @escaping (Error) -> Bool) {
        
        self.maxRetries = maxRetries
        
        self.shouldRetry = shouldRetry
    }
}
