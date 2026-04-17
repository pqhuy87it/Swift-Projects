//
//  DisplaySearchViewController.swift
//  SearchBar
//
//  Created by HuyPQ22 on 2021/08/28.
//

import UIKit

class DisplaySearchViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: ResultViewController())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        let vc = searchController.searchResultsController as? ResultViewController
        vc?.view.backgroundColor = .yellow
        print(text)
    }

}
