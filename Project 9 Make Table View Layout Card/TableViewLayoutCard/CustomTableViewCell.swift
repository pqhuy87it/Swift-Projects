
import UIKit

class CustomTableViewCell: UITableViewCell {

	@IBOutlet weak var bgView: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		self.setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setup() {
		bgView.backgroundColor = UIColor.white
		bgView.layer.borderColor = UIColor.Gray7.cgColor
		bgView.layer.borderWidth = 0.5
		bgView.layer.shadowColor = UIColor.Gray7.cgColor
		bgView.layer.shadowOffset = CGSize(width: 0, height: 1)
		bgView.layer.shadowRadius = 1.0
		bgView.layer.shadowOpacity = 0.9
	}
    
}
