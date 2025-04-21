//
//  Builder.swift
//  FormMaster
//
//  Created by JH on 2023/7/3.
//  Copyright © 2023 FormMaster. All rights reserved.
//

import Foundation

@dynamicMemberLookup
public struct Builder<Subject> {
    private let subject: Subject
    
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<Subject, Value>) -> ((Value) -> Builder<Subject>) {
        
        // 获取到真正的对象
        var subject = self.subject
        
        return { value in
            // 把 value 指派给 subject
            subject[keyPath: keyPath] = value
            // 回传的类型是 Setter 而不是 Subject
            // 因为使用Setter来链式，而不是 Subject 本身
            return Builder(subject)
        }
    }
    public init(_ subject: Subject) {
        self.subject = subject
    }
    
    public func build() -> Subject {
        return subject
    }
}
