//
//  WebController.swift
//  WebView
//
//  Created by aribons on 2018/07/25.
//  Copyright © 2018年 lesimo. All rights reserved.
//

import UIKit
import WebKit

class WebController: NSObject, WKUIDelegate, WKNavigationDelegate {

    // プロパティ
    var wkWebView: WKWebView! // 作成する webview
    var targetView: UIView! // webview を表示する view
    var srcUrl: String! // webview に表示する URL

    // イニシャライザ
    override init(){
        super.init()
    }
    
    // メソッド
    // createWebView メソッド
    // 引数の view 内に webview を作成する。戻り値は作成した webview オブジェクトを戻す。
    // @param UIView webview を表示する view
    // @return WKWebView webview
    func createWebView(_ targetView: UIView!) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: targetView.frame, configuration: webConfiguration)
        targetView.addSubview(wkWebView)
        
        return wkWebView
    }
    
    // customizeWebView メソッド
    // 複数の ViewController を使用するための制約設定
    // @param WKWebView webview
    // @param UIView webview を表示する view
    // @return none
    func customizeWebView(_ wkWebView: WKWebView!, _ targetView: UIView!){
        // [参考] https://stackoverflow.com/questions/40856112/how-to-create-a-sized-wkwebview-in-swift-3-ios-10/43242864
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        wkWebView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor).isActive = true
        wkWebView.topAnchor.constraint(equalTo: targetView.topAnchor).isActive = true
        wkWebView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor).isActive = true
        wkWebView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor).isActive = true
    }

    // loadUrl メソッド
    // 引数で指定した URL を webview に表示する
    // @param WKWebView webview
    // @param String URL
    // @return none
    func loadUrl(_ wkWebView: WKWebView!, _ srcUrl: String!){
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        
        let targetUrl = URL(string: srcUrl)
        let targetRequest = URLRequest(url: targetUrl!)

        wkWebView.load(targetRequest)
    }

    /*
    // エラーハンドリング
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) { // Web 読み込み中エラー
        <#code#>
    }
        
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) { // web 読み込み開始時のエラー（ネットワーク圏外など）
        <#code#>
    }
    */

}
