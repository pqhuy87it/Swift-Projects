import Foundation

extension MovieViewController: MovieViewModelDelegate {
    func getDataMoviesSuccess() {
        self.movieTableView.reloadData()
    }
    
    func handleGetMoviesFailedWith(_ error: NetworkError) {
        
    }
    
    func prepareForGetData() {
        
    }
}
