//
//  InputInfo.swift
//  YMTools
//
//  Created by apple on 2020/9/11.
//  Copyright © 2020 ym. All rights reserved.
//

import Foundation

public struct CommendItem: Hashable {
    let key: String?
    let values: [String]
    var value: String? {
        return values.first
    }
}

public struct InputInfo {
    let path: String?
    let commendContent: Set<CommendItem>
    
}
