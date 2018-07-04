//
//  SketchesTableViewDataSource.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/04.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation
import UIKit

class SketchesTableViewDataSource: NSObject {
    var sketches = [Sketch]()
    init(sketches: [Sketch]) {
        self.sketches = sketches
    }
}

extension SketchesTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear
        cell.textLabel?.attributedText = sketches[indexPath.row].cellTitleText()

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = #colorLiteral(red: 0.3954828928, green: 0.7799801496, blue: 0.7085735162, alpha: 1)
        cell.selectedBackgroundView = selectedBackgroundView
        cell.selectedBackgroundView?.layer.cornerRadius = 5.0
        cell.selectedBackgroundView?.clipsToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sketches.count
    }
}
