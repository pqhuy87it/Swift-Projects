import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var movieViewModel: MovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movies"
        
        self.setupUI()
        self.setupViewModel()
        self.setupData()
    }
    
    func setupUI() {
        self.movieTableView.register(UINib(nibName: "MovieCell", bundle: .main), 
                                     forCellReuseIdentifier: "MovieCell")
    }
    
    func setupViewModel() {
        let networkManager = NetworkManager()
        let movieRepository = MovieRepository(networkManager: networkManager)
        self.movieViewModel = MovieViewModel(delegate: self, movieRepository: movieRepository)
    }
    
    func setupData() {
        self.movieViewModel.getDataMovies()
    }
}
