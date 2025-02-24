
import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 
        //init wkwebview configuration
        let configuretion = WKWebViewConfiguration()
        configuretion.preferences = WKPreferences()
        configuretion.preferences.isElementFullscreenEnabled = true
               
        // init wkwebview
        self.webView = WKWebView(frame: self.view.bounds,
                                 configuration: configuretion)
        let url = Bundle.main.url(forResource: "test", withExtension: "html")
        self.webView.load(URLRequest(url: url!))
        self.bgView.addSubview(self.webView)
        
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        
        self.disableScrollView(self.webView)
    }
    
    func disableScrollView(_ view: UIView) {
        (view as? UIScrollView)?.isScrollEnabled = false
        view.subviews.forEach { disableScrollView($0) }
    }
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    self.webViewHeightConstraint.constant = height as! CGFloat
                })
            }

        })
    }
    
}

