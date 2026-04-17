//
//  ViewController.swift
//  TemplateProject
//
//  Created by HuyPQ22 on 2021/08/22.
//

import UIKit

typealias Subject = (title: String, description: String?)

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Subject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        items = [
            Subject(title: "Select text", description: "Select all text on label when touch."),
            Subject(title:"Keyboard Accessory", description: "Keyboard Accessory Example"),
            Subject(title: "ShowHideKeyboard", description: "Show hide keyboard on textField."),
            Subject(title: "PickerView Input", description: "TextField input from picker view"),
            Subject(title: "Left View", description: ""),
            Subject(title: "Placeholder Color", description: "")
        ]
        
        tableView.backgroundColor = UIColor.white
        tableView.registerCellByNib(MainViewCell.self)
    }

    func handleDidTapTableViewAt(_ indexpath: IndexPath) {
        switch indexpath.row {
        case 0:
            self.selectAllTextOnLabel()
            break
        case 1:
            self.keyboardAccessory()
            break
        case 2:
            self.showHideKeyboard()
            break
        case 3:
            self.pickerViewInput()
            break
        case 4:
            self.showLeftView()
            break
        case 5:
            self.showPlaceHolderColor()
            break
        case 6:
            break
        case 7:
            break
        case 8:
            break
        case 9:
            break
        case 10:
            break
        default:
            break
        }
    }
    
    func selectAllTextOnLabel() {
        if let selectTextVC = SelectTextController.fromStoryboard(Storyboards.SelectText.name) as? SelectTextController {
            self.navigationController?.pushViewController(selectTextVC, animated: true)
        }
    }
    
    func keyboardAccessory() {
        if let keyboardAccessoryVC = KeyboardAccessoryViewController.fromStoryboard(Storyboards.KeyboardAccessory.name) as? KeyboardAccessoryViewController {
            self.navigationController?.pushViewController(keyboardAccessoryVC, animated: true)
        }
    }
    
    func showHideKeyboard() {
        if let showHideKeyboardVC = ShowHideKeyboardViewController.fromStoryboard(Storyboards.ShowHideKeyboard.name) as? ShowHideKeyboardViewController {
            self.navigationController?.pushViewController(showHideKeyboardVC, animated: true)
        }
    }
    
    func pickerViewInput() {
        if let pickerViewInputVC = PickerViewInputViewController.fromStoryboard(Storyboards.PickerViewInput.name) as? PickerViewInputViewController {
            self.navigationController?.pushViewController(pickerViewInputVC, animated: true)
        }
    }
    
    func showLeftView() {
        if let vc = LeftViewController.fromStoryboard(Storyboards.LeftView.name) as? LeftViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showPlaceHolderColor() {
        if let vc = PlaceHolderColorController.fromStoryboard(Storyboards.PlaceHolderColor.name) as? PlaceHolderColorController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(MainViewCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let subject = items[indexPath.row]
        
        cell.configWith(title: subject.title, description: subject.description)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handleDidTapTableViewAt(indexPath)
    }
}


