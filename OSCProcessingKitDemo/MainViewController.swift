//
//  MainViewController.swift
//  OSCProcessingKitDemo
//
//  Created by AtsuyaSato on 2018/07/04.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import UIKit
import ProcessingKit

enum ViewMode: String {
    case code = "Code"
    case sketch = "Sketch"
}

class MainViewController: UIViewController {

    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    @IBOutlet weak var mainNavigationItem: UINavigationItem!
    @IBOutlet weak var sketchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var codeTextView: CodeTextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    let sketches: [Sketch] = [.colorful, .colorful, .colorful]
    lazy var dataSource = {
        return SketchesTableViewDataSource(sketches: sketches)
    }()
    var selectedSketch: Sketch = .colorful
    var mode: ViewMode = .sketch

    override func viewDidLoad() {
        super.viewDidLoad()
        guard
            let scrollPosition = UITableViewScrollPosition(rawValue: 0),
            let sketch = sketches.first else {
                return
        }
        selectedSketch = sketch

        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.reloadData()
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: scrollPosition)

        let titleLabel = UILabel()
        titleLabel.attributedText = sketch.mainViewTitleText()
        titleLabel.sizeToFit()

        let iconView = UIImageView(image: UIImage(named: "logo"))
        mainNavigationItem.leftBarButtonItems = [UIBarButtonItem(customView: iconView), UIBarButtonItem(customView: titleLabel)]

        switchSketch(sketch: sketch)
        setCodeView(language: .processing, sketch: sketch)
        switchMode(mode: mode)
    }

    private func switchSketch(sketch: Sketch) {
        let switchedSketchView = sketch.instantiateView(frame: sketchView.bounds)
        sketchView.subviews.forEach({ $0.removeFromSuperview() })
        sketchView.addSubview(switchedSketchView)
        setCodeView(language: .processing, sketch: sketch)
    }

    private func switchMode(mode: ViewMode) {
        switch mode {
        case .code:
            codeTextView.isHidden = false
            sketchView.isHidden = true
            segmentedControl.isHidden = false
            barButtonItem.title = ViewMode.sketch.rawValue
        case .sketch:
            codeTextView.isHidden = true
            sketchView.isHidden = false
            segmentedControl.isHidden = true
            barButtonItem.title = ViewMode.code.rawValue
        }
    }

    private func setCodeView(language: CodeLanguage, sketch: Sketch) {
        guard let code = try? String(contentsOfFile: Bundle.main.path(forResource: sketch.fileName, ofType: language.fileType) ?? "") else {
            return
        }
        codeTextView.highlight(code: code, language: language)
    }

    @IBAction func didTap(_ sender: UIBarButtonItem) {
        switch mode {
        case .code:
            mode = .sketch
        case .sketch:
            mode = .code
        }
        switchMode(mode: mode)
    }

    @IBAction func didChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            setCodeView(language: .processing, sketch: selectedSketch)
        case 1:
            setCodeView(language: .swift, sketch: selectedSketch)
        default:
            break
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSketch = sketches[indexPath.row]
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = tableView.backgroundColor

        let label = UILabel()
        label.text = "SKETCHES"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = UIColor.lightGray
        label.frame = CGRect(x: 15, y: 0, width: 120, height: 40)
        headerView.addSubview(label)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
