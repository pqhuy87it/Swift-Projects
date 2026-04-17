

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkBox: Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTapGesture()
    }

    func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.checkBox.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // do something
        if self.checkBox.checkState == .unchecked {
            self.checkBox.setCheckState(.checked, animated: true)
        } else {
            self.checkBox.setCheckState(.unchecked, animated: true)
        }
    }

}

