//
//  ParserService.swift
//  YMTools
//
//  Created by apple on 2020/9/11.
//  Copyright © 2020 ym. All rights reserved.
//

import Foundation

public class ParserService: NSObject {
    
    weak var delegate: ParserServiceDelegate?
//    private(set) lazy var configuration : Configuration = {
//        return Configuration()
//    }()
//
//    convenience init(configuration: Configuration) {
//        self.init()
//        self.configuration = configuration
//    }
    
    func arguments(_ arguments: [String]) throws -> InputInfo {
        
        typealias ContainerType = (key: () -> String?, append: (String) -> Void, push: () -> Void)
        
        var items = Set<CommendItem>()
        var path : String?
        
        func container(key: String?) -> ContainerType {
            var values = [String]()
            func appendValue(_ value: String) {
                values.append(value)
            }
            func pushValues() {
                items.insert(CommendItem(key: key, values: values))
            }
            return ({key}, appendValue, pushValues)
        }
        var containers = [ContainerType]()
        
        for (index, value) in arguments.enumerated() {
            
            if index == 0 && (self.delegate?.service(self, isPathFirstValue: value) ?? true) {
                path = value
                continue
            }
            if self.delegate?.service(self, isCommendKey: value) ?? (containers.count == 0) {
                containers.append(container(key: value))
                continue
            }
            let result = self.delegate?.service(self, isCommendValue: value, forKey: containers.last?.key()) ?? (containers.count != 0, true)
            if result.0 {
                containers.last?.append(value)
            }
            if result.1 {
                containers.popLast()?.push()
            }
        }
        for container in containers {
            container.push()
        }
        return InputInfo(path: path, commendContent: items)
    }
}
