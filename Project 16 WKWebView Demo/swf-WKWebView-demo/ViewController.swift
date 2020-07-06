//
//  ViewController.swift
//  swf-WKWebView-demo
//
//  Created by S.Emoto on 2018/07/29.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit
import WebKit  // WebKitをインポート

class ViewController: UIViewController {

    private var wkWebView: WKWebView!  // 現時点(2018/07/29)storyboardから作成できないのでコードで生成
    private let demoURL = "https://www.apple.com/jp/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWKWebView()
        load(withURL: demoURL)
    }
}

extension ViewController {
    
    // MARK: - Setup WKWebView
    private func setupWKWebView() {
        
        let webConfig = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: .zero, configuration: webConfig)
        wkWebView.uiDelegate = self  // jsとの連携系
        wkWebView.navigationDelegate = self  // 画面の読み込み・遷移系
        
        view = wkWebView
    }
    
    // MARK: - Load Web Page
    private func load(withURL urlStr:String) {
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        
        wkWebView.load(request)
    }
}

// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    
    // MARK: - Read settings (before request)
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("読み込み設定（リクエスト前）")
        
        /*
         * WebView内の特定のリンクをタップした時の処理などが書ける
         */
        let url = navigationAction.request.url
        print("読み込もうとしているページのURLが取得できる: ", url ?? "")
        
        /*  これを設定しないとアプリがクラッシュする
         *  .allow  : 読み込み許可
         *  .cancel : 読み込みキャンセル
         */
        decisionHandler(.allow)
    }
    
    // MARK: - Ready to read
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    // MARK: - Read setting (after getting response)
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("decidePolicyFor navigationResponse")
        
        /*  これを設定しないとアプリがクラッシュする
         *  .allow  : 読み込み許可
         *  .cancel : 読み込みキャンセル
         */
        decisionHandler(.allow)
        // 注意：受け取るレスポンスはページを読み込みタイミングのみで、Webページでの操作後の値などは受け取れない
    }
    
    // MARK: - Start reading
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit navigation")
    }
    
    // MARK: - User authentication
    // (If you do not call this method, you will not be authenticated)
    func webView(_ webView: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("didReceive challenge")
        completionHandler(.useCredential, nil)
    }
    
    // MARK: - Read complete
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation")
    }
    
    // MARK: - Read failure detection
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError: Error) {
        print("didFailProvisionalNavigation")
    }
    
    // MARK: - Read failure
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError: Error) {
        print("didFail navigation")
    }
    
    // MARK: - redirect
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation:WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation")
    }
    
    func loadHtmlCode() {
        let htmlCode = "<html><head><title>Wonderful web</title></head> <body><p>wonderful web. loading html code in <strong>UIWebView</strong></></body>"
        wkWebView.loadHTMLString(htmlCode, baseURL: nil)
    }
}

// MARK: - WKUIDelegate
// (Collaboration system with js)
extension ViewController: WKUIDelegate {
    
    // alertを表示する
    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "title",
                                                message: "message",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            completionHandler()
        }
        
        alertController.addAction(okAction)
        
        present(alertController ,animated: true ,completion: nil)
    }
    
    // confirm dialogを表示する
    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "title",
                                                message: "message",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completionHandler(false)
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            completionHandler(true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController ,animated: true ,completion: nil)
    }
    
    // Display the input form (prompt)
    func webView(_ webView: WKWebView,
                 runJavaScriptTextInputPanelWithPrompt prompt: String,
                 defaultText: String?,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "title",
                                                message: prompt,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completionHandler("")
        }
        
        let okHandler = { () -> Void in
            if let textField = alertController.textFields?.first {
                completionHandler(textField.text)
            } else {
                completionHandler("")
            }
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            okHandler()
        }
        
        alertController.addTextField() { $0.text = defaultText }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController ,animated: true ,completion: nil)
    }
}
