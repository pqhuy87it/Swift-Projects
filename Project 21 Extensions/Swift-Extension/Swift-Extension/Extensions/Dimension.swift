
import UIKit

public class Dimension {
    public static var shared = Dimension()
    
    var widthScale: CGFloat = 1.0
    var heightScale: CGFloat = 1.0
    
    private init() {
        let witdthIPXR: CGFloat = 414
        let heightIPXR: CGFloat = 896
        widthScale = UIScreen.main.bounds.width / witdthIPXR
        heightScale = UIScreen.main.bounds.height / heightIPXR
    }
    
    //MARK: FontSize
    
    public var fontSizeTextMonth: CGFloat {
        return 10 * heightScale
    }
    
}
