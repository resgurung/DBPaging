//
//  CoreDataInterceptor.swift
//  CoreDataInterceptor
//
//  Created by Robin Gurung on 25/08/2021.
//

import Foundation
import CoreData

/*
    Subclass CoreDataInterceptor to customize for intercept(_)
 */
open class CoreDataInterceptor<Key, Value, DataSource: CoreDataInterceptorDataSourceProtocol>: PagingInterceptor<Key, Value>
where DataSource.Key == Key, DataSource.Value == Value {
    
    private let dataSource: DataSource
    
    public init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    public override func intercept(request: PagingRequest<Key>) throws -> PagingInterceptResult<Key, Value> {
        
        guard let moc = request.moc else {
            
            return .proceed(request, handleAfterwards: false)
        }
        
        if case .refresh(_) = request, (request.params.userInfo?[CoreDataInterceptorUserInfoParams.hardRefresh] as? Bool) == true {
            try dataSource.deleteAll(in: moc)
        }
        
        let pageSize = request.params.pageSize
        
        let values = try dataSource.get(request: request)
        
        if values.count < pageSize {
            //debugPrint("db proceed, don't have data")
            return .proceed(request, handleAfterwards: false) // done automatically
        } else {
            //debugPrint("db has data for request: \(request)")
            return .complete(Page(request: request, values: values))
        }
    }
}
