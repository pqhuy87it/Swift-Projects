//
//  VisualFormatLanguageController.swift
//  Autolayout
//
//  Created by Pham Quang Huy on 2022/01/01.
//

import UIKit

class VisualFormatLanguageController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var numberSections: [String] = []
    let headerID = "Header"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }
    
    func setupUI() {
        self.tableView.registerCellByNib(VisualFormatLanguageCell.self)
        self.tableView.registerHeaderFooter(VisualFormatLanguageHeaderView.self)
        
        // setup data
        self.numberSections = [
            "H:[object(==value)], V:[object(==value)]",
            "H:|-value-[object], V:|-value-[object]",
            "H:[object]-value-|, V:[object]-value-|",
            "H:|-value-[object]-value-|",
            "V:|-value-[object]-value-|",
            "H:[object1(==object2)], V:[object1(==object2)]",
            "H:|-value-[object1]-[object2]-[object3]-value]-|"
        ]
    }
    
    func configCell(_ cell: VisualFormatLanguageCell, at indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                // create new button
                let button = UIButton(type: UIButton.ButtonType.system)
                button.backgroundColor = UIColor.yellow
                button.setTitle("button", for: .normal)
                cell.mainView.addSubview(button)
                
                // create contrains
                let views = ["button": button]
                
                views.forEach { $1.translatesAutoresizingMaskIntoConstraints = false }
                
                button.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[button(==140)]",
                                                                     options: .alignAllTop,
                                                                     metrics: nil,
                                                                     views: views))
                button.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[button(==50)]",
                                                                     options: .alignAllTop,
                                                                     metrics: nil,
                                                                     views: views))
            case 1:
                // create new button
                let button = UIButton(type: UIButton.ButtonType.system)
                button.backgroundColor = UIColor.yellow
                button.setTitle("button", for: .normal)
                cell.mainView.addSubview(button)
                
                // create contrains
                let views = ["button": button]
                
                var allConstraints: [NSLayoutConstraint] = []
                
                views.forEach { $1.translatesAutoresizingMaskIntoConstraints = false }
                
                // align layer from the left
                let buttonLeftHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[button]",
                                                                                    metrics: nil,
                                                                                    views: views)
                allConstraints += buttonLeftHorizontalConstraints
                
                // align layer from the top
                let buttonTopHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[button]",
                                                                                    metrics: nil,
                                                                                    views: views)
                allConstraints += buttonTopHorizontalConstraints
                // active constrains
                NSLayoutConstraint.activate(allConstraints)
            case 2:
                // create new button
                let button = UIButton(type: UIButton.ButtonType.system)
                button.backgroundColor = UIColor.yellow
                button.setTitle("button", for: .normal)
                cell.mainView.addSubview(button)
                
                // create contrains
                let views = ["button": button]
                
                var allConstraints: [NSLayoutConstraint] = []
                
                views.forEach { $1.translatesAutoresizingMaskIntoConstraints = false }
                
                // align layer from the right
                let buttonRightHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[button]-20-|",
                                                                                     metrics: nil,
                                                                                     views: views)
                allConstraints += buttonRightHorizontalConstraints
                
                // align layer from the bottom
                let buttonBottomVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[button]-20-|",
                                                                                     metrics: nil,
                                                                                     views: views)
                allConstraints += buttonBottomVerticalConstraints
                
                // active constrains
                NSLayoutConstraint.activate(allConstraints)
            case 3:
                // create new button
                let button = UIButton(type: UIButton.ButtonType.system)
                button.backgroundColor = UIColor.yellow
                button.setTitle("button", for: .normal)
                cell.mainView.addSubview(button)
                
                // create contrains
                let views = ["button": button]
                
                var allConstraints: [NSLayoutConstraint] = []
                
                views.forEach { $1.translatesAutoresizingMaskIntoConstraints = false }
                
                // align layer from the left and right
                let buttonLeftRightHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[button]-20-|",
                                                                                          metrics: nil,
                                                                                          views: views)
                allConstraints += buttonLeftRightHorizontalConstraints
                
                // active constrains
                NSLayoutConstraint.activate(allConstraints)
            case 4:
                // create new button
                let button = UIButton(type: UIButton.ButtonType.system)
                button.backgroundColor = UIColor.yellow
                button.setTitle("button", for: .normal)
                cell.mainView.addSubview(button)
                
                // create contrains
                let views = ["button": button]
                
                var allConstraints: [NSLayoutConstraint] = []
                
                views.forEach { $1.translatesAutoresizingMaskIntoConstraints = false }
                
                // align layer from the top and bottom
                let buttonTopBottomVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[button]-20-|",
                                                                                        metrics: nil,
                                                                                        views: views)
                allConstraints += buttonTopBottomVerticalConstraints
                
                // active constrains
                NSLayoutConstraint.activate(allConstraints)
                
            case 5:
                // create new button
                let button = UIButton(type: UIButton.ButtonType.system)
                button.backgroundColor = UIColor.yellow
                button.setTitle("button", for: .normal)
                cell.mainView.addSubview(button)
                
                let textField = UITextField()
                textField.borderStyle = .roundedRect
                textField.text = "textfield"
                cell.mainView.addSubview(textField)
                
                // create contrains
                let views =  ["button":button,"textField":textField]
                
                var allConstraints: [NSLayoutConstraint] = []
                
                views.forEach { $1.translatesAutoresizingMaskIntoConstraints = false }
                
                // align layer from the left
                let buttonLeftHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[button]",
                                                                                     metrics: nil,
                                                                                     views: views)
                allConstraints += buttonLeftHorizontalConstraints
                
                // align layer from the top
                let buttonTopHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[button]",
                                                                                    metrics: nil,
                                                                                    views: views)
                allConstraints += buttonTopHorizontalConstraints
                
                // align textfield from the right
                let textfieldRightHorizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[textField]-20-|",
                                                                                        metrics: nil,
                                                                                        views: views)
                allConstraints += textfieldRightHorizontalContraints
                
                // align textfield from the top
                let textfieldTopHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[textField]",
                                                                                       metrics: nil,
                                                                                       views: views)
                allConstraints += textfieldTopHorizontalConstraints
                
                //
                let buttonTextfieldHeightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[button(==textField)]",
                                                                                      options: .alignAllBottom,
                                                                                      metrics: nil,
                                                                                      views: views)
                allConstraints += buttonTextfieldHeightConstraints
                
                //
                let buttonTextfieldWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[button(==textField)]",
                                                                                     options: .alignAllBottom,
                                                                                     metrics: nil,
                                                                                     views: views)
                allConstraints += buttonTextfieldWidthConstraints
                
                // button and textfield distance constraints
                let buttonTextfieldDistanceConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[button]-10-[textField]",
                                                                                        options: .alignAllBottom,
                                                                                        metrics: nil,
                                                                                        views: views)
                allConstraints += buttonTextfieldDistanceConstraints
                
                // active constrains
                NSLayoutConstraint.activate(allConstraints)
                
            case 6:
                var allConstraints: [NSLayoutConstraint] = []
                
                // create cancel button
                let cancelBtn = UIButton(type: UIButton.ButtonType.system)
                cancelBtn.backgroundColor = UIColor.yellow
                cancelBtn.setTitle("Cancel", for: .normal)
                cell.mainView.addSubview(cancelBtn)
                
                // create ok button
                let okBtn = UIButton(type: UIButton.ButtonType.system)
                okBtn.backgroundColor = UIColor.yellow
                okBtn.setTitle("OK", for: .normal)
                cell.mainView.addSubview(okBtn)
                
                // create textfield
                let textField = UITextField()
                textField.borderStyle = .roundedRect
                textField.text = "textfield"
                cell.mainView.addSubview(textField)
                
                let views =  ["okBtn":okBtn,
                              "cancelBtn":cancelBtn,
                              "textField": textField]
                
                views.forEach { $1.translatesAutoresizingMaskIntoConstraints = false }
                
                // create okBtn vertical constraints
                let okBtnVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[okBtn]",
                                                                              metrics: nil,
                                                                              views: views)
                allConstraints += okBtnVerticalConstraints
                
                let visualFormatStr = "H:|-15-[okBtn(50)]-[textField]-[cancelBtn]-15-|"
                let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: visualFormatStr,
                                                                           options: [.alignAllCenterY], // comment se thay 3 item ko thang hang
                                                                           metrics: nil,
                                                                           views: views)
                allConstraints += horizontalConstraints
                // active constrains
                NSLayoutConstraint.activate(allConstraints)
            default:
                break
        }
    }
}

//MARK: - UITableViewDataSource

extension VisualFormatLanguageController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(VisualFormatLanguageCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        
        self.configCell(cell, at: indexPath)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension VisualFormatLanguageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueHeaderFooter(VisualFormatLanguageHeaderView.self) else {
            return nil
        }
        
        headerView.headerTitle.text = numberSections[section]
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
