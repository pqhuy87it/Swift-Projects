
import UIKit
import PassKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupApplePayButton()
    }
    
    @IBAction func addCardBtnPressed(_ sender: Any) {
        
    }
    
    
    private func setupApplePayButton() {
        let passKitButton = PKAddPassButton(addPassButtonStyle: .blackOutline)
        passKitButton.addTarget(self, action: #selector(onEnroll), for: .touchUpInside)
        view.addSubview(passKitButton)
        passKitButton.translatesAutoresizingMaskIntoConstraints = false
        passKitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        passKitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        passKitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    @objc private func onEnroll(button: UIButton) {
        // 1
        guard isPassKitAvailable() else {
            showPassKitUnavailable(message: "InApp enrollment not available for this device")
            return
        }
        
        // 2
        initEnrollProcess()
    }
    
    /**
     Init enrollment process
     */
    private func initEnrollProcess() {
        // 3
        let card = cardInformation()
        // 4
        guard let configuration = PKAddPaymentPassRequestConfiguration(encryptionScheme: .ECC_V2) else {
            showPassKitUnavailable(message: "InApp enrollment configuraton fails")
            return
        }
        
        configuration.cardholderName = card.holder
        configuration.primaryAccountSuffix = card.panTokenSuffix
        
        guard let enrollViewController = PKAddPaymentPassViewController(requestConfiguration: configuration, delegate: self) else {
            showPassKitUnavailable(message: "InApp enrollment controller configuration fails")
            return
        }
        
        // 5
        present(enrollViewController, animated: true, completion: nil)
    }
    
    /**
     Define if PassKit will be available for this device
     */
    private func isPassKitAvailable() -> Bool {
        return PKAddPaymentPassViewController.canAddPaymentPass()
    }
    
    /**
     Show an alert that indicates that PassKit isn't available for this device
     */
    private func showPassKitUnavailable(message: String) {
        let alert = UIAlertController(title: "InApp Error",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /**
     Return the card information that Apple will display into enrollment screen
     */
    private func cardInformation() -> Card {
        return Card(panToken: "1234 1234 1234 1234", panTokenSuffix: "1234", holder: "Carl Jonshon")
    }
}

extension ViewController: PKAddPaymentPassViewControllerDelegate {
    func addPaymentPassViewController(_ controller: PKAddPaymentPassViewController,
                                      generateRequestWithCertificateChain certificates: [Data],
                                      nonce: Data,
                                      nonceSignature: Data,
                                      completionHandler handler: @escaping (PKAddPaymentPassRequest) -> Void) {
        
        // Perform the bridge from Apple -> Issuer -> Apple
        
        // 1
        let request = IssuerRequest(certificates: certificates,
                                    nonce: nonce,
                                    nonceSignature: nonceSignature)
        
        // 2
        let interactor = GetPassKitDataIssuerHostInteractor()
        interactor.execute(request: request) { response in
            // 3
            let request = PKAddPaymentPassRequest()
            request.activationData = response.activationData
            request.ephemeralPublicKey = response.ephemeralPublicKey
            request.encryptedPassData = response.encryptedPassData
            handler(request)
        }
    }
    
    func addPaymentPassViewController(_ controller: PKAddPaymentPassViewController, didFinishAdding pass: PKPaymentPass?, error: Error?) {
        
        // This method will be called when enroll process ends (with success / error)
        
        // 4
        if let _ = pass {
            print("Everything it's ok!")
        } else {
            print("Oops, something fails!")
        }
    }
}

