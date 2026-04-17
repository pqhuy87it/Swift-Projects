import Foundation

protocol MovieDetailViewModelDelegate: BaseViewModelDelegate {
    func getMovieDetailCreditDataSuccess()
    func getMovieDetailReviewDataSuccess()
    func handleGetMovieDetailCreditFailed(_ error: NetworkError)
    func handleGetMovieDetailReviewFailed(_ error: NetworkError)
}

@MainActor
class MovieDetailViewModel {
    
    weak var delegate: MovieDetailViewModelDelegate?
    
    private var movieDetailCreditRepository: MovieDetailCreditRepository
    private var movieDetailReviewRepository: MovieDetailReviewRepository
    
    private var movieCasts: [MovieCast] = []
    private var movieReviews: [MovieReview] = []
    
    var getMovieDetailCreditIsError: Bool = false
    var getMovieDetailReviewIsError: Bool = false
    
    var movieDetailCreditError: NetworkError?
    var movieDetailReviewError: NetworkError?
    
    init(delegate: MovieDetailViewModelDelegate? = nil,
         movieDetailCreditRepository: MovieDetailCreditRepository,
         movieDetailReviewRepository: MovieDetailReviewRepository) {
        self.delegate = delegate
        self.movieDetailCreditRepository = movieDetailCreditRepository
        self.movieDetailReviewRepository = movieDetailReviewRepository
    }
    
    func getMovieCreditCount() -> Int {
        return self.movieCasts.count
    }
    
    func getMovieReviewCount() -> Int {
        return self.movieReviews.count
    }
    
    func getMovieCreditAt(_ index: Int) -> MovieCast {
        return self.movieCasts[index]
    }
    
    func getMovieReviewAt(_ index: Int) -> MovieReview {
        return self.movieReviews[index]
    }
    
    // MARK: - API
    
    func getMovieDetailData() {
        self.delegate?.prepareForGetData()
        
        Task {
            let movieDetailCreidtResult = try? await self.movieDetailCreditRepository.fetchMovieDetailCredit()
            
            switch movieDetailCreidtResult {
            case .success(let response):
                if let object = response.objects {
                    self.getMovieDetailCreditIsError = false
                    self.movieCasts = object.cast
                    
                    self.delegate?.getMovieDetailCreditDataSuccess()
                } else {
                    self.getMovieDetailCreditIsError = true
                    let networkError = NetworkError(errorCode: NetworkErrorCode.nilData,
                                                    error: nil)
                    self.movieDetailCreditError = networkError
                    
                    self.delegate?.handleGetMovieDetailCreditFailed(networkError)
                }
                
            case .failure(let error):
                self.movieDetailCreditError = error
                self.getMovieDetailCreditIsError = true
                self.delegate?.handleGetMovieDetailCreditFailed(error)
            default:
                break
            }
        }
        
        Task {
            let movieDetailReviewResult = try? await self.movieDetailReviewRepository.fetchMovieDetailReview()
            
            switch movieDetailReviewResult {
            case .success(let response):
                if let object = response.objects {
                    self.getMovieDetailReviewIsError = false
                    self.movieReviews = object.results
                    
                    self.delegate?.getMovieDetailReviewDataSuccess()
                } else {
                    self.getMovieDetailReviewIsError = true
                    let networkError = NetworkError(errorCode: NetworkErrorCode.nilData,
                                                    error: nil)
                    self.movieDetailReviewError = networkError
                    
                    self.delegate?.handleGetMovieDetailReviewFailed(networkError)
                }
            case .failure(let error):
                self.movieDetailReviewError = error
                self.getMovieDetailReviewIsError = true
                self.delegate?.handleGetMovieDetailReviewFailed(error)
            default:
                break
            }
        }
    }
}
