//
//  SimpleTouchView.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/05.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class SimpleTouch: ProcessingView {
    func setup() {
        background(255, 255, 255)
        fill(255,0 ,0)
    }

    func draw() {
        if fingerPressed {
            ellipse(touchX, touchY, 20, 20)
        }
    }
}

