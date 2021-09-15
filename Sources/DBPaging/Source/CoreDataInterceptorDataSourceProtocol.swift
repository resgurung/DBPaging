//
//  CoreDataInterceptorOutput.swift
//  Paging2.0
//
//  Created by Robin Gurung on 28/08/2021.
//

import Foundation
import CoreData

/**
 Used for keys to pass parameters needed by **CoreDataInterceptor** in **PagingRequestParams.userInfo**.
 */
public enum CoreDataInterceptorUserInfoParams {
    
    case moc // NSManagedObjectContext to use with CoreData
    
    case hardRefresh // set to true to purge the DB on a refresh
}

public protocol CoreDataInterceptorDataSourceProtocol {
        
    associatedtype Key: Equatable // request key
    
    associatedtype Value: NSManagedObject // coredata model
    
    associatedtype RemoteValue // remote object model
    
    func get(request: PagingRequest<Key>) throws -> [Value] // fetch data from the DB based on the provided request
    
    func insert(remoteValues: [RemoteValue], in moc: NSManagedObjectContext) throws -> [Value] // store data that came from PagingSource into the DB and return the mapped values
    
    func insertSS(remoteValues: [RemoteValue], completion: ([Value]) -> ())
    
    func deleteAll(in moc: NSManagedObjectContext) throws
}
