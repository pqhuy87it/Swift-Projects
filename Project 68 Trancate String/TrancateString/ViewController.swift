
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    
    @IBOutlet weak var lb3: UILabel!
    @IBOutlet weak var lb4: UILabel!
    
    @IBOutlet weak var lb5: UILabel!
    @IBOutlet weak var lb6: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lb1.text = nil
        lb2.text = nil
        
        lb3.text = nil
        lb4.text = nil
        
        lb5.text = nil
        lb6.text = nil
        
        testTruncateString(lb1: lb1,
                           lb2: lb2,
                           str1: "aaaaaaaaaaaaaaaaaaaaaaaa",
                           str2: "bbbbbbbbbbbbbbbbbbbbbbbb")
        testTruncateString(lb1: lb3,
                           lb2: lb4,
                           str1: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                           str2: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb")
        
        testTruncateString(lb1: lb5,
                           lb2: lb6,
                           str1: "aaaaaaa",
                           str2: "bbbbbbb")
    }
    
    func testTruncateString(lb1: UILabel, lb2: UILabel, str1: String, str2: String) {
        lb1.text = "\(str1) \(str2)"
        
        if lb1.isTruncated {
            lb1.text = str1
            lb2.text = str2
        }
    }

}

extension UILabel {
    var isTruncated: Bool {
        guard let labelText = text as? NSString,
                let font = font else {
            return false
        }
        
        let size = labelText.size(withAttributes: [NSAttributedString.Key.font: font])
            return size.width > self.bounds.width
        }
}
