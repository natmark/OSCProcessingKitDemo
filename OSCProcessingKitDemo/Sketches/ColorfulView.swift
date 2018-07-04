//
//  ColorfulView.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/04.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation
import UIKit
import ProcessingKit

class ColorfulView : ProcessingView {
    func setup() {
        background(0, 0, 0)
        noStroke()
    }

    func draw() {
        print(fingerPressed)
        if fingerPressed {
            fill(UIColor(hue: random(255) / 255.0, saturation: 255 / 255.0, brightness: 255 / 255.0, alpha: 255 / 255.0))
            let size = CGFloat(Int(random(20)) % 18)
            ellipse(touchX + random(20) - 10, touchY + random(20) - 10, size, size)
        }
    }

    func random(_ i: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(i)))
    }
}
