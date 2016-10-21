//
//  connectJaran.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

final class ConnectJaran: NSObject {
    
    /// APIKey
    private let APIKey = "ari157d11cb342"
    
    /// それぞれのタグのフラグ
    private var elementFlgs = ["HotelID": false, "HotelName": false, "Prefecture": false, "LargeArea": false, "HotelType": false, "PictureURL": false, "PlanName": false, "PlanDetailURL": false, "PlanPictureURL": false, "Meal": false, "PlanSampleRateFrom": false ]
    
    private var pictureURL = [String]()
    
    func connectDbJaran() -> [String] {
        print("kokomadekita")
        let str = "青木"
        let url = "http://jws.jalan.net/APIAdvance/HotelSearch/V1/?key=\(APIKey)&xml_ptn=2&h_name=\(str)"
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

extension ConnectJaran: NSXMLParserDelegate {
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("XML解析開始")
    }
    
    // 解析中に要素の開始タグがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementFlgs[elementName] != nil {
            elementFlgs[elementName] = true
        }
    }
    
    // 開始タグと終了タグでくくられたデータがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        for (_, _) in elementFlgs {
//            if flg {
//                elements["\(name)"] = string
//            }
            
        }
        
    }
    
    // 解析中に要素の終了タグがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementFlgs[elementName] != nil {
            elementFlgs[elementName] = false
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
