//
//  Sketch.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/05.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import ProcessingKit
import UIKit

enum Sketch: EnumCollection {
    case colorful
    case simpleTouch
    case ripple
    case particle
    case oekakiWebSocket

    var name: String {
        switch self {
        case .colorful:
            return "Colorful"
        case .simpleTouch:
            return "SimpleTouch"
        case .ripple:
            return "Ripple"
        case .particle:
            return "Particle"
        case .oekakiWebSocket:
            return "OekakiWebSocket"
        }
    }

    var fileName: String {
        switch self {
        case .colorful:
            return "Colorful"
        case .simpleTouch:
            return "SimpleTouch"
        case .ripple:
            return "Ripple"
        case .particle:
            return "Particle"
        case .oekakiWebSocket:
            return "OekakiWebSocket"
        }
    }
}

extension Sketch {
    func instantiateView(frame: CGRect) -> ProcessingView {
        let view: ProcessingView
        switch self {
        case .colorful:
            view = ColorfulView(frame: frame)
        case .simpleTouch:
            view = SimpleTouch(frame: frame)
        case .ripple:
            view = RippleView(frame: frame)
        case .particle:
            view = ParticleView(frame: frame)
        case .oekakiWebSocket:
            view = OekakiWebSocketView(frame: frame)
        }
        return view
    }
}

extension Sketch {
    func cellTitleText() -> NSAttributedString {
        let stringAttributes1: [NSAttributedStringKey : Any] = [
            .foregroundColor : UIColor.gray,
            .font : UIFont.systemFont(ofSize: 20.0)
        ]
        let string1 = NSAttributedString(string: "#  ", attributes: stringAttributes1)

        let stringAttributes2: [NSAttributedStringKey : Any] = [
            .foregroundColor : UIColor.white,
            .font : UIFont.boldSystemFont(ofSize: 20.0)
        ]
        let string2 = NSAttributedString(string: self.name, attributes: stringAttributes2)

        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(string1)
        mutableAttributedString.append(string2)
        return mutableAttributedString
    }

    func mainViewTitleText() -> NSAttributedString {
        let stringAttributes1: [NSAttributedStringKey : Any] = [
            .foregroundColor : UIColor.gray,
            .font : UIFont.systemFont(ofSize: 18.0)
        ]
        let string1 = NSAttributedString(string: "# ", attributes: stringAttributes1)

        let stringAttributes2: [NSAttributedStringKey : Any] = [
            .foregroundColor : UIColor.black,
            .font : UIFont.boldSystemFont(ofSize: 18.0)
        ]
        let string2 = NSAttributedString(string: self.name, attributes: stringAttributes2)

        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(string1)
        mutableAttributedString.append(string2)
        return mutableAttributedString
    }
}
