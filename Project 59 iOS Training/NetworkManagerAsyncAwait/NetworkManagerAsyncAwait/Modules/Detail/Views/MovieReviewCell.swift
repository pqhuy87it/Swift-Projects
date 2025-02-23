import UIKit

class MovieReviewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reviewCellConfiguration( review: MovieReview) {
        authorLabel.text = review.author
        contentLabel.text = review.content
    }
}
