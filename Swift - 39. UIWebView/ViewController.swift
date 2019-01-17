//
//  ViewController.swift
//  Swift - 39. UIWebView
//
//  Created by Oleksandr Bardashevskyi on 1/17/19.
//  Copyright © 2019 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let stringUrl = "google.com"
        let url = URL(string: "https://"+stringUrl)!
        let urlReauest: URLRequest = URLRequest(url: url)
        
        webView.load(urlReauest)
        
        urlTextField.text = stringUrl
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let stringUrl = urlTextField.text!
        let url = URL(string: "https://"+stringUrl)!
        let urlReauest: URLRequest = URLRequest(url: url)
        
        webView.load(urlReauest)
        textField.resignFirstResponder()
        return true
    }
}
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        
        urlTextField.text = webView.url?.absoluteString
    }
}
