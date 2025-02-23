import Foundation

class MovieRepository {
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchMovies() async throws -> NetworkResult<NetworkResponse<MovieResponse>>? {
        let movieRequest = MovieRequest()
        
        return try await networkManager.execute(movieRequest)
    }
}
