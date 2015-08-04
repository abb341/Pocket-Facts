//
//  WebViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/20/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate  {
    
    //IBOutlets
    @IBOutlet weak var webView: UIWebView!
    
    //IBActions
    @IBAction func doRefresh(AnyObject) {
        webView.reload()
    }
    
    @IBAction func goBack(AnyObject) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForward(AnyObject) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    var requestURL = "https://www.google.com"
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWebView()
        loadAddressURL()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        println("WebView Disappeared")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        removeWebView()
    }
    
    // MARK: Convenience
    func loadAddressURL() {
        if let requestURL = NSURL(string: self.requestURL) {
            //LoadingOverlay.shared.showOverlay(self.view)
            let request = NSURLRequest(URL: requestURL)
            webView.loadRequest(request)
            //LoadingOverlay.shared.hideOverlayView()
        }
    }
    
    func configureWebView() {
        webView.backgroundColor = UIColor.whiteColor()
        webView.scalesPageToFit = true
    }
    
    func removeWebView() {
        requestURL = ""
        //loadAddressURL()
        self.webView = nil
    }
    
    
    // MARK: UIWebViewDelegate
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


