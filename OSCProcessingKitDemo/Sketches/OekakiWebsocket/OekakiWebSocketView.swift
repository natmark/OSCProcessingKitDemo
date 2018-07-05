//
//  OekakiWebSocketView.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/05.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import UIKit
import ProcessingKit
import Starscream

struct Point: Codable, Hashable {
    let red: Int
    let green: Int
    let blue: Int
    let x: Int
    let y: Int
}

struct Color {
    let red: Int
    let green: Int
    let blue: Int

    init(_ red: Int, _ green: Int, _ blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

enum PaintColor: Int {
    case red
    case green
    case blue
    case purple
    case aqua
    case yellow
}

class OekakiWebSocketView: ProcessingView {
    var selectedPaintColor: PaintColor = .red
    let socket = WebSocket(url: URL(string: "ws://127.0.0.1:8080/")!)
    var points: Set<Point> = []
    let colors: [Color] = [
        Color(192, 0, 0),
        Color(0, 192, 0),
        Color(0, 0, 192),
        Color(192, 0, 192),
        Color(0, 192, 192),
        Color(192, 192, 0),
    ]

    func setup() {
        socket.delegate = self
        socket.connect()

        noStroke()
        strokeWeight(2.0)
        textSize(32)
    }

    func draw() {
        background(255, 255, 255)

        if !socket.isConnected {
            fill(0,0,255)
            text("Connecting to remote oekaki server...", 50, height/2)
            return
        }

        for (index, element) in colors.enumerated() {
            if index == selectedPaintColor.rawValue {
                stroke(128, 128, 128)
            } else {
                noStroke()
            }
            fill(CGFloat(element.red), CGFloat(element.green), CGFloat(element.blue))
            ellipse(30, CGFloat((index+1) * 50), 30, 30)
        }

        fill(255, 0 ,0)
        text("X", 20, height - 50)

        if fingerPressed {
            fingerTapped()
        }

        for point in points {
            noStroke()
            fill(CGFloat(point.red), CGFloat(point.green), CGFloat(point.blue))
            ellipse(CGFloat(point.x), CGFloat(point.y), 10, 10)
        }
    }

    func fingerTapped() {
        for i in 0 ..< colors.count {
            if(touchX > 15 && touchX < 45 && Int(touchY) > ((i+1) * 50 - 15) && Int(touchY) < ((i+1) * 50 + 15)){
                selectedPaintColor = PaintColor(rawValue: i) ?? .red
                return
            }
        }

        if(touchX > 15 && touchX < 45 && touchY > height - 80 && touchY < height - 50){
            let jsonObj = ["delete": true]
            guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObj, options: []) else {
                return
            }

            let jsonStr = String(bytes: jsonData, encoding: .utf8) ?? ""
            socket.write(string: jsonStr)
            return
        }

        let jsonObj: [String: Int] = [
            "red": colors[selectedPaintColor.rawValue].red,
            "green": colors[selectedPaintColor.rawValue].green,
            "blue": colors[selectedPaintColor.rawValue].blue,
            "x": Int(touchX),
            "y": Int(touchY)
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObj, options: []) else {
            return
        }

        let jsonStr = String(bytes: jsonData, encoding: .utf8)!

        points.insert(Point(red: colors[selectedPaintColor.rawValue].red, green: colors[selectedPaintColor.rawValue].green, blue: colors[selectedPaintColor.rawValue].blue, x: Int(touchX), y: Int(touchY)))
        socket.write(string: jsonStr)
    }
}

extension OekakiWebSocketView: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        guard let decodeObj = try? JSONDecoder().decode([Point].self, from: text.data(using: .utf8)!) else {
            return
        }
        for point in decodeObj {
            points.insert(point)
        }
        if decodeObj.count == 0 {
            points.removeAll()
        }
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    }
}
