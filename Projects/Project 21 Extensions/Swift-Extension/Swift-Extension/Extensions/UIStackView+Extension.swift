
import Foundation
import UIKit

extension UIStackView {
    func setTextFontColor() {
        self.arrangedSubviews.forEach { (view) in
            guard let label:UILabel = view as? UILabel else {return}
            label.font = UIFont.systemFont(ofSize: Dimension.shared.fontSizeTextMonth)
            label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    func postChangeTextColor(_ indexs:Int,_ showHide:Bool,_ stateData:Bool) {
        for index in self.arrangedSubviews.indices {
            guard let label:UILabel =  self.arrangedSubviews[index] as? UILabel else {return}
            if indexs == index && stateData && !showHide {
                label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                label.font = UIFont.systemFont(ofSize: Dimension.shared.fontSizeTextMonth, weight: .bold)
            } else {
                label.textColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
                label.font =  UIFont.systemFont(ofSize: Dimension.shared.fontSizeTextMonth)
            }
        }

    }
}
