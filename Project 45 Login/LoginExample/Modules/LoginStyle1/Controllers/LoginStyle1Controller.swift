import UIKit

class LoginStyle1Controller: UIViewController, UIViewControllerTransitioningDelegate {
    var btn: TKTransitionSubmitButton!

    @IBOutlet weak var btnFromNib: TKTransitionSubmitButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(image: UIImage(named: "Login"))
        bg.frame = self.view.frame
        self.view.addSubview(bg)

        btn = TKTransitionSubmitButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 64, height: 44))
        btn.center = self.view.center
        btn.backgroundColor = .red
        btn.frame.bottom = self.view.frame.height - 60
        btn.setTitle("Sign in", for: UIControl.State())
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        btn.addTarget(self, action: #selector(LoginStyle1Controller.onTapButton(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)

        self.view.bringSubviewToFront(self.btnFromNib)
    }

    @IBAction func onTapButton(_ button: TKTransitionSubmitButton) {
        button.animate(1, completion: { () -> () in
            let secondVC = LoginStyle1SecondController()
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .fullScreen
            self.present(secondVC, animated: true, completion: nil)
        })
    }

    // MARK: UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

