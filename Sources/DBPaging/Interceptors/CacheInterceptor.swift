//
//  CacheInterceptor.swift
//  CacheInterceptor
//
//  Created by Robin Gurung on 25/08/2021.
//

import Foundation


// has to be here, because Swift
public let cacheInterceptorDefaultExpirationInterval = TimeInterval(10 * 60) // 10 min

public class CacheInterceptor<Key: Hashable, Value>: PagingInterceptor<Key, Value> {
    private let expirationInterval: TimeInterval
    private var cache = [Key: CacheEntry]()
    
    public init(expirationInterval: TimeInterval = cacheInterceptorDefaultExpirationInterval) {
        self.expirationInterval = expirationInterval
    }
    
    public override func intercept(request: PagingRequest<Key>) throws -> PagingInterceptResult<Key, Value> {
        pruneCache() // remove expired items
        if let cached = cache[request.key] {
            return .complete(cached.page) // complete the request with the cached page
        } else {
            return .proceed(request, handleAfterwards: true) // don't have data, proceed...
        }
    }
    
    public override func handle(result page: Page<Key, Value>) {
        cache[page.key] = CacheEntry(page: page) // store result in cache
    }
    
    private func pruneCache() {
        let now = Date().timeIntervalSince1970
        let keysToRemove = cache.keys.filter { now - (cache[$0]?.timestamp ?? 0) > expirationInterval }
        for key in keysToRemove {
            cache.removeValue(forKey: key)
        }
    }
    
    private struct CacheEntry {
        let page: Page<Key, Value>
        let timestamp: TimeInterval = Date().timeIntervalSince1970
    }
}
