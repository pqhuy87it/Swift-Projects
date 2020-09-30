
import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: MultiLanguageLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.baseView.backgroundColor = UIColor.hexStringToUIColor("CBEEFF", alpha: 1.0)
        } else {
            self.baseView.backgroundColor = UIColor.white
        }
    }

}
