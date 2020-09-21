//
//  DetailViewController.swift
//  newsZennex
//
//  Created by Zakirov Tahir on 05.09.2020.
//  Copyright © 2020 Zakirov Takhir. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
    
    var webSite: String?
    var webTitle: String?
    @IBOutlet var webView: WKWebView!
    
    override func loadView() {
        self.navigationItem.title = webTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let webSite = webSite else { return }
        guard let url = URL(string: webSite) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

   

}
