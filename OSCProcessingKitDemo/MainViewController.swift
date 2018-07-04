//
//  MainViewController.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/04.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainNavigationItem: UINavigationItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    let dataSource = SketchesTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.reloadData()

        let stringAttributes1: [NSAttributedStringKey : Any] = [
            .foregroundColor : UIColor.gray,
            .font : UIFont.systemFont(ofSize: 18.0)
        ]
        let string1 = NSAttributedString(string: "# ", attributes: stringAttributes1)

        let stringAttributes2: [NSAttributedStringKey : Any] = [
            .foregroundColor : UIColor.black,
            .font : UIFont.boldSystemFont(ofSize: 18.0)
        ]
        let string2 = NSAttributedString(string: "Colorful", attributes: stringAttributes2)

        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(string1)
        mutableAttributedString.append(string2)
        let attributedText = mutableAttributedString

        let titleLabel = UILabel()
        titleLabel.attributedText = attributedText
        titleLabel.sizeToFit()

        let iconView = UIImageView(image: UIImage(named: "logo"))
        mainNavigationItem.leftBarButtonItems = [UIBarButtonItem(customView: iconView), UIBarButtonItem(customView: titleLabel)]
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
