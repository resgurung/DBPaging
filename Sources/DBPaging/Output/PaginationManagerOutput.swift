//
//  PaginationManagerOutput.swift
//  PaginationManagerOutput
//
//  Created by Robin Gurung on 25/08/2021.
//

import Foundation


public protocol PaginationManagerOutput {
    associatedtype Value
    static var initial: Self { get }
    init(isRefreshing: Bool, isPrepending: Bool, isAppending: Bool, values: [Value])
    var isRefreshing: Bool { get }
    var isPrepending: Bool { get }
    var isAppending: Bool { get }
    var values: [Value] { get }
}

/**
 Default implementation of **PaginationManagerOutput**. Can be used to jump-start custom **PaginationManager** or when there's no need for more logic requiring a custom **PaginationManagerOutput** implementation.
 */
public struct DefaultPaginationManagerOutput<Value>: PaginationManagerOutput {
    public static var initial: DefaultPaginationManagerOutput<Value> {
        DefaultPaginationManagerOutput(isRefreshing: false,
                                       isPrepending: false,
                                       isAppending: false,
                                       values: [])
    }
    
    public let isRefreshing: Bool
    public let isPrepending: Bool
    public let isAppending: Bool
    public let values: [Value]
    
    public init(isRefreshing: Bool,
                isPrepending: Bool,
                isAppending: Bool,
                values: [Value]) {
        self.isRefreshing = isRefreshing
        self.isPrepending = isPrepending
        self.isAppending = isAppending
        self.values = values
    }
}
