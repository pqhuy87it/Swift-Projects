

import UIKit

class LeftViewController: UIViewController {

    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let im = UIImage(named:"sun.jpeg")
        let sz = CGSize(width: 16, height: 16)
        let r = UIGraphicsImageRenderer(size: sz)
        let im2 = r.image {_ in
            im?.draw(in: CGRect(origin: .zero, size: sz))
        }
        tf.leftView = UIImageView(image:im2)
        tf.leftViewMode = .always
        tf.leftViewMode = .whileEditing
        tf.leftViewMode = .unlessEditing
        tf.clearButtonMode = .whileEditing
        
        // tf.keyboardType = .numberPad
        
        // proving that editing attributes is possible even if none to start
//        tf.allowsEditingTextAttributes = true
        tf.text = "Howdy there"
        // tf.clearsOnBeginEditing = true
        // tf.clearsOnInsertion = true
        
        tf.borderStyle = .none
        // tf.borderStyle = .bezel
         tf.borderStyle = .line
        // tf.borderStyle = .roundedRect
        tf.background = UIImage(named:"yellowsilk4")
        
        do {
            let r = UIGraphicsImageRenderer(size: sz)
            let im2 = r.image {ctx in
                ctx.cgContext.strokeEllipse(in: CGRect(origin:.zero, size:sz))
            }
            tf.background = im2.resizableImage(withCapInsets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))

        }
    }


}

