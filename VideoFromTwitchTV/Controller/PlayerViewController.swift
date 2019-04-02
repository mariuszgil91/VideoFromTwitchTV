//
//  PlayerViewViewController.swift
//  VideoFromTwitchTV
//
//  Created by Mariusz Gil on 02/04/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import UIKit
import WebKit

class PlayerViewController: UIViewController, WKUIDelegate {

    
    var webView: WKWebView!
    var streamURL = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: streamURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}
