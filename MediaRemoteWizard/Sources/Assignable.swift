//
//  Assignable.swift
//  FormMaster
//
//  Created by JH on 2023/11/15.
//  Copyright © 2023 FormMaster. All rights reserved.
//

import Foundation

public protocol Assignable: AnyObject {}

extension Assignable {
    public func assign<each T>(for value: Self, keyPaths: repeat ReferenceWritableKeyPath<Self, each T>) {
        repeat self[keyPath: each keyPaths] = value[keyPath: each keyPaths]
    }
}
