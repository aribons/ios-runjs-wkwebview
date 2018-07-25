//
//  Scraping.swift
//  WebView
//
//  Created by aribons on 2018/07/25.
//  Copyright © 2018年 lesimo. All rights reserved.
//

import UIKit
import WebKit

class Scraping: NSObject {

    // プロパティ
    //  No Property

    // イニシャライザ
    override init(){
        super.init()
    }
    
    // メソッド
    // scrapeNews メソッド
    // 引数で指定した webview 内のニュースタイトルを取得し、引数で指定したラベルに表示する。
    // @param WKWebView webview
    // @param UILabel label
    // @return none
    func scrapeNews(_ wkWebView: WKWebView!, _ newsLabel: UILabel!){
        // webview 内の <body></body> 部 HTML 取得
        wkWebView.evaluateJavaScript(
            "document.body.innerHTML",
            completionHandler: { (value: Any?, error: Error?) in
                if let htmlBody = value as? String {
                    // <body></body> 部 HTML からニュースタイトルを取得
                    let newsTitle: String! = self.getNewsTitle(htmlBody)

                    // ニュースタイトルを描画
                    self.renderNewsTitle(newsLabel, newsTitle)
                }
            }
        )
    }
    
    // getNewsTitle メソッド
    // 引数で指定した HTML 内のニュースタイトルを取得する。
    // @param String <body></body> 部の HTML
    // @return String ニュースタイトル
    private func getNewsTitle(_ htmlBody: String?) -> String {
        // 取得したニュースタイトル
        var newsTitle: String! = ""
        
        // ニュースタイトル取得のための HTML 区切り文字
        // (YAHOO News は 3 回に分けてニュースタイトルを取得していく)
        let split1stDelim: String! = "StreamItem__title--ellipsis"
        let split2ndDelim: String! = ">"
        let split3rdDelim: String! = "<"

        // htmlBody が nil の時の処理
        if let strHtmlBody = htmlBody {
            // ニュースタイトルの取得
            let split1stHtml = strHtmlBody.components(separatedBy: split1stDelim)
            
            for var i:Int! in 1..<split1stHtml.count {
                var split2ndHtml = split1stHtml[i].components(separatedBy: split2ndDelim)
                var split3rdHtml = split2ndHtml[1].components(separatedBy: split3rdDelim)
                
                newsTitle = newsTitle + "・" + split3rdHtml[0] + "\n"
            }
            
            return newsTitle
        // htmlBody が not nil の時の処理
        } else {
            newsTitle = "ニュースはありません。"
            return newsTitle
        }
    }

    // renderNews メソッド
    // 引数で指定したラベルにニュースタイトルを表示する。
    // @param UILabel label
    // @param String ニュースタイトル
    // @return none
    internal func renderNewsTitle(_ newsLabel: UILabel!, _ newsTitle: String!){
        newsLabel.text = newsTitle
        newsLabel.numberOfLines = 0 // 改行有効化
    }
}
