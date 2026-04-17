import UIKit
// MARK: - 2. Content VC (Nội dung danh sách tìm kiếm)
class NativeSearchContentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    let data = ["Marked Location", "San Francisco Airport", "Golden Gate Bridge", "Pier 39", "Union Square", "Lombard Street", "Alcatraz", "Twin Peaks", "Palace of Fine Arts", "Baker Beach"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .clear
        
        searchBar.placeholder = "Search Maps"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // TableView Config
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "mappin.circle.fill")
        cell.imageView?.tintColor = .systemRed
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { tableView.deselectRow(at: indexPath, animated: true) }
}
