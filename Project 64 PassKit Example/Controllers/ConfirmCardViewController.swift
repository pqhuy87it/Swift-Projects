
import Foundation
import UIKit

class ConfirmCardViewController: UIViewController {
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var cardNumberTf: UITextField!
    
    var cardRegisterAtApplePay: IsCardRegisterAtApplePayInteractorImpl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.cardRegisterAtApplePay = IsCardRegisterAtApplePayInteractorImpl(pairedDeviceRepository: PairedDeviceRepositoryImpl(), passKitRepository: InAppPassKitRepositoryImpl())
    }
    
    @IBAction func confirmCardBtnTapped(_ sender: Any) {
        let name = self.nameTf.text ?? ""
        let cardNumber = self.cardNumberTf.text ?? ""
        
        let card = Card(panToken: cardNumber,
                        panTokenSuffix: String(cardNumber.suffix(4)),
                        holder: name)
        
        if let isExist = self.cardRegisterAtApplePay?.checkExist(card), isExist {
            let message = "Card ****-****-****-\(card.panTokenSuffix.suffix(4)) existing!"
            self.showAlertErrorWith(message)
        } else {
            let message = "Card ****-****-****-\(card.panTokenSuffix.suffix(4)) is available to add in wallet."
            self.showAlertWith(message)
        }
    }
 
    /**
     Show an alert
     */
    private func showAlertErrorWith(_ message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertWith(_ message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
