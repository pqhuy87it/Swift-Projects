//
//  ViewController.swift
//  FloatingController
//
//  Created by huy on 2025/03/01.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var observations: [NSKeyValueObservation] = []
    private lazy var useCaseController = UseCaseController(mainVC: self)
}

extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        automaticallyAdjustsScrollViewInsets = false

        let searchController = UISearchController(searchResultsController: nil)
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.largeTitleDisplayMode = .automatic
        }
        var insets = UIEdgeInsets.zero
        insets.bottom += 69.0
        tableView.contentInset = insets

        // Show the initial panel
        useCaseController.set(useCase: .trackingTableView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            if let observation = navigationController?.navigationBar.observe(\.prefersLargeTitles, changeHandler: { (bar, _) in
                self.tableView.reloadData()
            }) {
                observations.append(observation)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        observations.removeAll()
    }
}

extension MainViewController {
    @IBAction func showDebugMenu(_ sender: UIBarButtonItem) {
        useCaseController.setUpSettingsPanel(for: self)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if #available(iOS 11.0, *) {
            if navigationController?.navigationBar.prefersLargeTitles == true {
                return UseCase.allCases.count + 30
            } else {
                return UseCase.allCases.count
            }
        } else {
            return UseCase.allCases.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if UseCase.allCases.count > indexPath.row {
            let menu = UseCase.allCases[indexPath.row]
            cell.textLabel?.text = menu.name
        } else {
            cell.textLabel?.text = "\(indexPath.row) row"
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard UseCase.allCases.count > indexPath.row else { return }

        // Change panels
        useCaseController.set(useCase: UseCase.allCases[indexPath.row])
    }

    @objc func dismissPresentedVC() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}

