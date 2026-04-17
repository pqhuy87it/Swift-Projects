import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var descMovie: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetUpCell()
    }
    
    private func initialSetUpCell() {
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.layer.masksToBounds = true
        posterImage.backgroundColor = .lightGray
        posterImage.layer.borderColor = UIColor.lightGray.cgColor
        posterImage.layer.borderWidth = 1.0
        posterImage.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellConfiguration(movie: Movie) {
//        if ARAPI.isAsyncType {
            configureUsingAsync(movie: movie)
//        } else {
//            configureUsingNormal(movie: movie)
//        }
    }
}


extension MovieCell {
    
    private func configureUsingAsync(movie: Movie) {
        titleMovie.text = movie.title
        descMovie.text = movie.overview
        
        Task {
            posterImage.image = try await movie.posterImage
            
            if let posterURL = movie.posterURL {
               try await posterImage.asynAwaitloadImageUsingCacheFromURL(posterURL)
            }
        }
    }
}


extension MovieCell {
    
    private func configureUsingNormal(movie: Movie) {
        titleMovie.text = movie.title
        descMovie.text = movie.overview
        if let posterURL = movie.posterURL {
            posterImage.loadImageUsingCacheWithURLString(posterURL)
        }
    }
}
