import Foundation

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func prepareForGetData() {
        
    }
    
    func handleGetMovieDetailCreditFailed(_ error: NetworkError) {
        switch error.errorCode {
        case .nilData:
            // Process nil data need to implement
            break
        case .badRequest:
            // Process bad request need to implement
            break
        case .jsonDecodeError:
            // Process json decode error need to implement
            break
        case .notFound:
            // Process not found
            break
        default:
            // Do something
            break
        }
        
        self.detailTableView.reloadData()
    }
    
    func handleGetMovieDetailReviewFailed(_ error: NetworkError) {
        switch error.errorCode {
        case .nilData:
            // Process nil data need to implement
            break
        case .badRequest:
            // Process bad request need to implement
            break
        case .jsonDecodeError:
            // Process json decode error need to implement
            break
        default:
            // Do something
            break
        }
        
        self.detailTableView.reloadData()
    }
    
    func getMovieDetailCreditDataSuccess() {
        self.detailTableView.reloadData()
    }
    
    func getMovieDetailReviewDataSuccess() {
        self.detailTableView.reloadData()
    }
}
