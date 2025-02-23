import Foundation

protocol MovieViewModelDelegate: BaseViewModelDelegate {
    func getDataMoviesSuccess()
    func handleGetMoviesFailedWith(_ error: NetworkError)
}

@MainActor
class MovieViewModel {
    weak var delegate: MovieViewModelDelegate?
    
    private var movieRepository: MovieRepository
    private var movies: [Movie] = []
    
    var selectedIndex: Int = 0
    
    init(delegate: MovieViewModelDelegate, movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        self.delegate = delegate
    }
    
    func getMoviewsCount() -> Int {
        return self.movies.count
    }
    
    func getMovieAt(_ index: Int) -> Movie {
        return self.movies[index]
    }
    
    func getSelectedMovieId() -> String {
        guard self.selectedIndex >= 0 else {
            return ""
        }
        
        return self.movies[self.selectedIndex].id.description
    }
    
    // MARK: - API
    
    func getDataMovies() {
        self.delegate?.prepareForGetData()
        Task {
            let result = try? await self.movieRepository.fetchMovies()
            
            switch result {
            case .success(let response):
                if let object = response.objects {
                    self.movies = object.results
                    
                    self.delegate?.getDataMoviesSuccess()
                } else {
                    let networkError = NetworkError(errorCode: NetworkErrorCode.nilData,
                                                    error: nil)
                    
                    self.delegate?.handleGetMoviesFailedWith(networkError)
                }
                
            case .failure(let error):
                self.delegate?.handleGetMoviesFailedWith(error)
            case .none:
                break
            }
        }
    }
}
