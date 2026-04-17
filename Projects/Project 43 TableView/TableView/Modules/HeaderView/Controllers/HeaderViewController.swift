//
//  HeaderViewController.swift
//  TableView
//
//  Created by Pham Quang Huy on 2022/01/02.
//

import UIKit

class HeaderViewController: UITableViewController {

    struct Section {
        var sectionName : String
        var rowData : [String]
    }
    var sections : [Section]!
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    let cellID = "Cell"
    let headerID = "Header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let s = try! String(
            contentsOfFile: Bundle.main.path(
                forResource: "states", ofType: "txt")!)
        let states = s.components(separatedBy:"\n")
        let d = Dictionary(grouping: states) {String($0.prefix(1))}
        self.sections = Array(d).sorted{$0.key < $1.key}.map {
            Section(sectionName: $0.key, rowData: $0.value)
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.tableView.registerHeaderFooter(HeaderView.self)
        
        self.tableView.sectionIndexColor = .white
        self.tableView.sectionIndexBackgroundColor = .red
        self.tableView.sectionIndexTrackingBackgroundColor = .blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rowData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        let s = self.sections[indexPath.section].rowData[indexPath.row]
        cell.textLabel!.text = s
        
        // this part is not in the book, it's just for fun
        var stateName = s
        stateName = stateName.lowercased()
        stateName = stateName.replacingOccurrences(of: " ", with:"")
        stateName = "flag_\(stateName).gif"
        let im = UIImage(named: stateName)
        cell.imageView!.image = im
        
        return cell
    }
    
    // showing how to design a header view in a nib
    // you have to design a content view and stuff it manually into the header view
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let h = tableView.dequeueHeaderFooter(HeaderView.self) else {
            return nil
        }
        
        h.contentView.backgroundColor = UIColor.Gray5
        h.lab.text = self.sections[section].sectionName
        return h
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // return 0
        return 22
        // return UITableViewAutomaticDimension
    }
    
    /*
     override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
     print(view) // prove we are reusing header views
     }
     */
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        // return nil
        return self.sections.map{$0.sectionName}
    }
}
