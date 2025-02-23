import UIKit

enum CellType: String, CaseIterable {
    case Cast
    case Review
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var movieDetailViewModel: MovieDetailViewModel!
    var movieViewModel: MovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setupViewModel()
        self.setupUI()
        self.setupData()
    }
    
    func setupViewModel() {
        let networkManager = NetworkManager()
        let movieDetailCreditRepository = MovieDetailCreditRepository(networkManager: networkManager, 
                                                                      movieId: self.movieViewModel.getSelectedMovieId())
        let movieDetailReviewRepository = MovieDetailReviewRepository(networkManager: networkManager, 
                                                                      movieId: self.movieViewModel.getSelectedMovieId())
        self.movieDetailViewModel = MovieDetailViewModel(delegate: self,
                                                         movieDetailCreditRepository: movieDetailCreditRepository,
                                                         movieDetailReviewRepository: movieDetailReviewRepository)
    }
    
    func setupUI() {
        self.detailTableView.register(UINib(nibName: "MovieCastCell", bundle: .main), 
                                      forCellReuseIdentifier: "MovieCastCell")
        self.detailTableView.register(UINib(nibName: "MovieReviewCell", bundle: .main), 
                                      forCellReuseIdentifier: "MovieReviewCell")
        self.detailTableView.register(UINib(nibName: "MovieCastErrorCell", bundle: .main),
                                      forCellReuseIdentifier: "MovieCastErrorCell")
        
        if #available(iOS 15, *) {
            self.detailTableView.sectionHeaderTopPadding = 0
        }
    }
    
    func setupData() {
        self.movieDetailViewModel.getMovieDetailData()
    }
}

