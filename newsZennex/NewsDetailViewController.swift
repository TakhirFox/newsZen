//
//  NewsDetailViewController.swift
//  newsZennex
//
//  Created by Zakirov Tahir on 06.09.2020.
//  Copyright © 2020 Zakirov Takhir. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    var postUrl: String?
    var postTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = postTitle
        guard let postUrl = postUrl else { return }
        guard let url = URL(string: postUrl) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    


}
