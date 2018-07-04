//
//  MainNavigationBar.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/05.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class MainNavigationBar: UINavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11.0, *) {
            for subview in self.subviews {
                let stringFromClass = NSStringFromClass(subview.classForCoder)
                if stringFromClass.contains("BarBackground") {
                    subview.frame = self.bounds
                } else if stringFromClass.contains("BarContentView") {
                    subview.frame.origin.y = UIApplication.shared.statusBarFrame.height
                    subview.frame.size.height = self.bounds.height - UIApplication.shared.statusBarFrame.height
                }
            }
        }
    }
}
