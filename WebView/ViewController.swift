//
//  ViewController.swift
//  WebView
//
//  Created by aribons on 2018/07/25.
//  Copyright © 2018年 lesimo. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    // プロパティ
    @IBOutlet weak var webViewWrapper: UIView!
    var wkWebView: WKWebView!
    var webController: WebController! = WebController()
    let srcUrl: String! = "https://yahoo.co.jp/"
    var scraping: Scraping! = Scraping()
    @IBOutlet weak var newsList: UILabel!

    // メソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // webview 作成 & URL 読み込み
        wkWebView = webController.createWebView(webViewWrapper) // 引数の view 内に webview を作成
        webController.loadUrl(wkWebView, srcUrl) // webview に web ページを表示

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // [ Get News ] ボタン押下時処理
    @IBAction func getNews(_ sender: Any) {
        scraping.scrapeNews(wkWebView, newsList)
    }
}
