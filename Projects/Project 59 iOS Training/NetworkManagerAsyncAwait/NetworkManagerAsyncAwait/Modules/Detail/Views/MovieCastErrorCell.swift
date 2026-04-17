import UIKit

class MovieCastErrorCell: UITableViewCell {

    @IBOutlet weak var errorLbContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWith(_ networkError: NetworkError?) {
        self.errorLbContent.text = networkError?.errorCode?.message
    }
}
