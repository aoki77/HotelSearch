//
//  connectDb.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

final class ConnectDb: NSObject {
    
    /// APIKey
    private let APIKey = "ari157d11cb342"
    
    private var elementFlg = false
    
    private var pictureURL = [String]()
    
    func connectDbJaran() -> [String] {
        print("kokomadekita")
        let str = "青木"
        let url = "http://jws.jalan.net/APIAdvance/HotelSearch/V1/?key=\(APIKey)&h_name=\(str)"
        let encodedUrl = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url2 = NSURL(string: encodedUrl)
        
        guard let parser = NSXMLParser(contentsOfURL: url2!) else { return [""] }
        
        parser.delegate = self
        
        // XMLのパースを開始
        let success = parser.parse()
        
        if success {
            print("パース成功")
        } else {
            print("パース失敗")
        }
        
        //guard let guardPictureURL = pictureURL else { return [""] }
        
        return pictureURL
        
    }
    
}

extension ConnectDb: NSXMLParserDelegate {
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("XML解析開始")
    }
    
    // 解析中に要素の開始タグがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "PictureURL" {
            elementFlg = true
        }
    }
    
    // 開始タグと終了タグでくくられたデータがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if elementFlg {
            pictureURL.append(string)
        }
        
    }
    
    // 解析中に要素の終了タグがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "PictureURL" {
            elementFlg = false
        }
    }
    
    // XML解析終了時に実行されるメソッド
    func parserDidEndDocument(parser: NSXMLParser) {
        print("XML解析終了しました")
    }
    
    // 解析中にエラーが発生した時に実行されるメソッド
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("エラー:" + parseError.localizedDescription)
    }
}
