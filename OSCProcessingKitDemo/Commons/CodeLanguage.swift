//
//  CodeLanguage.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/05.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

enum CodeLanguage: String {
    case swift
    case processing

    var fileType: String {
        switch self {
        case .swift:
            return "txt"
        case .processing:
            return "pde"
        }
    }
}
