import Foundation

class MovieDetailCreditRepository {
    var networkManager: NetworkManager
    var movieId: String
    
    init(networkManager: NetworkManager, movieId: String) {
        self.networkManager = networkManager
        self.movieId = movieId
    }
    
    func fetchMovieDetailCredit() async throws -> NetworkResult<NetworkResponse<MovieCredit>>? {
        var movieDetailCreditRequest = MovieDetailCreditRequest()
        movieDetailCreditRequest.movieId = movieId
        
        return try await self.networkManager.execute(movieDetailCreditRequest)
    }
}
