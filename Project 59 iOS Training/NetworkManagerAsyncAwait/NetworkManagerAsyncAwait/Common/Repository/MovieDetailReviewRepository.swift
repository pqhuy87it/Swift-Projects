import Foundation

class MovieDetailReviewRepository {
    var networkManager: NetworkManager
    var movieId: String
    
    init(networkManager: NetworkManager, movieId: String) {
        self.networkManager = networkManager
        self.movieId = movieId
    }
    
    func fetchMovieDetailReview() async throws -> NetworkResult<NetworkResponse<MovieReviewResponse>>? {
        var movieDetailReviewRequest = MovieDetailReviewRequest()
        movieDetailReviewRequest.movieId = self.movieId
        
        return try await self.networkManager.execute(movieDetailReviewRequest)
    }
}
