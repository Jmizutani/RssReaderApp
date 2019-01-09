//
//  DetailViewController.swift
//  RssReaderApp
//
//  Created by 水谷純也 on 2019/01/05.
//  Copyright © 2019 水谷純也. All rights reserved.
//

import UIKit
import SwiftyJSON
import TOWebViewController

class DetailViewController: TOWebViewController {

    var webview:UIWebView=UIWebView()
    var entry:Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webview.frame=self.view.bounds
        self.webview.delegate=self;
        self.view.addSubview(self.webview)
        
        let url=NSURL(string: self.entry!.link)
        let request=NSURLRequest(url: url as! URL)
        
        self.webview.loadRequest(request as URLRequest)
        // Do any additional setup after loading the view.
    }
    
    override func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible=true
    }
    
    override func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible=false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
