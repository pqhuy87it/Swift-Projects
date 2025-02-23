import UIKit

class MovieCastCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func creditCellConfiguration( cast: MovieCast) {
        nameLabel.text = cast.name
        characterLabel.text = "(\(cast.character))"
    }
}
