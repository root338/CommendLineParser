//
//  ParserServiceDelegate.swift
//  YMTools
//
//  Created by GML on 2020/9/12.
//  Copyright © 2020 ym. All rights reserved.
//

import Foundation

public protocol ParserServiceDelegate: NSObjectProtocol {
    
    /// 第一个参数是路径
    func service(_ service: ParserService, isPathFirstValue firstValue: String) -> Bool
    /// 是否是命令行的key值
    func service(_ service: ParserService, isCommendKey key: String) -> Bool
    /// 是否是命令行的 key 值下的内容
    func service(_ service: ParserService, isCommendValue value: String, forKey key: String?) -> (isValue: Bool, isPopKey: Bool)
}

public extension ParserServiceDelegate {
    func service(_ service: ParserService, isPathFirstValue firstValue: String) -> Bool {
        return true
    }
}
