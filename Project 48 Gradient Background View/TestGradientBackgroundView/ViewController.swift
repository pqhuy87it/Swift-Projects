
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let frame = UIScreen.main.bounds
        let gradientBg = GradientBackgroundView(frame: frame)
        gradientBg.startColor = Color.greenGradationTop.value
        gradientBg.endColor = Color.greenGradationBottom.value
        
        self.view.addSubview(gradientBg)
    }


}

