
import UIKit

class BlurAlertViewController: UIAlertController {

    var blurEffectView: VisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let presentingViewController: UIViewController = presentingViewController else {
            return
        }
        
        let view: UIView = presentingViewController.view
        // visual effect view
        let visualEffectView = VisualEffectView()
        visualEffectView.blurRadius = 6.0
        visualEffectView.colorTint = .black
        visualEffectView.colorTintAlpha = 0.5
        visualEffectView.frame = view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(visualEffectView)
        visualEffectView.alpha = 0
        self.blurEffectView = visualEffectView
        self.view.backgroundColor = .clear
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        visualEffectView.alpha = 1
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.blurEffectView?.alpha = 0
        }, completion: { _ in
            self.blurEffectView?.removeFromSuperview()
        })
    }

}
