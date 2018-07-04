//
//  CodeLanguage.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/05.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

enum CodeLanguage: String, EnumCollection {
    case processing
    case swift

    var fileType: String {
        switch self {
        case .processing:
            return "pde"
        case .swift:
            return "txt"
        }
    }
}
