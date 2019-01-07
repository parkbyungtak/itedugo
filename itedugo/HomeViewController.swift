//
//  ViewController.swift
//  itedugo
//
//  Created by 박병탁 on 31/12/2018.
//  Copyright © 2018 박병탁. All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var webView: WKWebView!
    
    let loadingBgView : UIView = UIView()
    
    var loadingGifImageView = UIImageView()
    
    var isFirstLoading : Bool = true
    
    var lastOffsetY :CGFloat = 0
    
    var isHome : Bool = true
    
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    @IBOutlet weak var forwardBtn: UIBarButtonItem!
    
    @IBAction func goHome(_ sender: Any) {
        homepageLoad()
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForward(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    
    @IBAction func reload(_ sender: Any) {
        webView.reload()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("userContetn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.scrollView.delegate = self

        webView.navigationDelegate = self
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        
        homepageLoad()
        
    }

    func homepageLoad() {
        let serviceURL = "http://itedugo.com/user/home"
        
        let url = URL(string: serviceURL)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}


extension HomeViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let otherAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(otherAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        // 로딩 애니메이션
        loadingGIF()
        
    }
    
    func loadingGIF() {
        
        // 로딩 배경 이미지(반투명)
        
        loadingBgView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        loadingBgView.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        // 로딩 이미지뷰 크기 설정
        loadingGifImageView.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        
        self.view.addSubview(loadingBgView)
        loadingBgView.addSubview(loadingGifImageView)
        //self.view.addSubview(loadingGifImageView)
        
        let jeremyGif = UIImage.gifImageWithName(name: "LoadingAnimation", duration: 5)
        
        loadingGifImageView.animationImages = jeremyGif?.images
        loadingGifImageView.animationRepeatCount = 0
        loadingGifImageView.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
  
        if webView.canGoBack == false {
            isHome = true
            backBtn.isEnabled = false
            self.navigationController?.setToolbarHidden(true, animated: false)
        }
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        if webView.canGoBack {
            isHome = false
            backBtn.isEnabled = true
            self.navigationController?.setToolbarHidden(false, animated: false)
        }
        
        if webView.canGoForward == true {
            forwardBtn.isEnabled = true
        } else {
            forwardBtn.isEnabled = false
        }
        
        // 웹뷰 로딩 처리 후 이미지 처리(삭제)
        self.loadingBgView.removeFromSuperview()
    }
}

extension HomeViewController : UIScrollViewDelegate {
    
//    func scrollViewWillBeginDragging(scrollView: UIScrollView){
//        lastOffsetY = scrollView.contentOffset.y
//    }
//
//    func scrollViewWillBeginDecelerating(scrollView: UIScrollView){
//
//        let hide = scrollView.contentOffset.y > self.lastOffsetY
//        self.navigationController?.setNavigationBarHidden(hide, animated: true)
//        self.navigationController?.setToolbarHidden(hide, animated: true)
//    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if isHome == false {
            lastOffsetY = scrollView.contentOffset.y
        }
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        if isHome == false {
            let hide = scrollView.contentOffset.y > self.lastOffsetY
            self.navigationController?.setNavigationBarHidden(hide, animated: true)
            self.navigationController?.setToolbarHidden(hide, animated: true)
        }
        
    }
    
}
