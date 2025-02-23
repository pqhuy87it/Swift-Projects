import Foundation
import UIKit

// MARK: - TableView Data Source

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieViewModel.getMoviewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            cell.cellConfiguration(movie: self.movieViewModel.getMovieAt(indexPath.row))
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let movieDetailVC = UIStoryboard(name: "MovieDetail", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        self.movieViewModel.selectedIndex = Bool.random() ? indexPath.row : -1
        movieDetailVC.movieViewModel = self.movieViewModel
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
