//
//  CodeTextView.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/05.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import UIKit
import Highlightr

class CodeTextView: UITextView {
    let codeAttrString = CodeAttributedString()

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    func configure(){
        textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20)
        sizeToFit()

        codeAttrString.highlightr.setTheme(to: "gruvbox-dark")
        codeAttrString.highlightr.theme.setCodeFont(UIFont(name: "Courier", size: 24.0) ?? UIFont.systemFont(ofSize: 24.0))
    }

    func highlight(code: String, language: CodeLanguage) {
        codeAttrString.language = language.rawValue
        attributedText = codeAttrString.highlightr.highlight(code)
        backgroundColor = codeAttrString.highlightr.theme.themeBackgroundColor
    }
}
