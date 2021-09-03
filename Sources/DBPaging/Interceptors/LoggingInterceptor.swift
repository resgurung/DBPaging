//
//  LoggingInterceptor.swift
//  LoggingInterceptor
//
//  Created by Robin Gurung on 25/08/2021.
//

import Foundation


public class LoggingInterceptor<Key: Equatable, Value>: PagingInterceptor<Key, Value> {
    private let log: (String) -> Void // allows for custom logging
    
    public init(log: ((String) -> Void)? = nil) {
        self.log = log ?? { print($0) }
    }
    
    public override func intercept(request: PagingRequest<Key>) throws -> PagingInterceptResult<Key, Value> {
        log("Sending pagination request: \(request)") // log the request
        return .proceed(request, handleAfterwards: true) // proceed with the request, without changing it
    }
    
    public override func handle(result page: Page<Key, Value>) {
        log("Received page: \(page)") // once the page is retuned, print it
    }
}
