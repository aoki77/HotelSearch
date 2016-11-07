//
//  connectJaran.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/10/19.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit

final class ConnectJalan: NSObject {
    
    // MARK: - 定数プロパティ
    
    /// APIKey
    private let APIKey = "ari157d11cb342"
    
    /// 表示件数
    private let count = 5
    
    /// 表示の並び順
    private let order = 4
    
    /// 都道府県番号
    private let prefectures = 130000
    
    // MARK: - 変数プロパティ
    
    private var hotelData: HotelData?
    
    private var hotelDataArray = [HotelData]()
    
    private var planNameFlag = true
    
    private var PlanDetailFlag = true
    
    /// それぞれのタグのフラグ(key名はタグ名と同一)
    private var elementFlgs = ["HotelName": false, "Prefecture": false, "LargeArea": false, "HotelCatchCopy": false, "PictureURL": false, "PlanName": false, "RoomName": false, "PlanDetailURL": false, "PlanSampleRateFrom": false ]
    
    // MARK: - スタティック関数
    
    /// お勧めのホテルのデータを取ってくる
    func connectRecommendHotel() -> [HotelData] {
        let url = "http://jws.jalan.net/APIAdvance/HotelSearch/V1/?key=\(APIKey)&xml_ptn=2&pref=\(prefectures)&count=\(count)&order=\(order)"
        let encodedUrl = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url2 = NSURL(string: encodedUrl)
        
        guard let parser = NSXMLParser(contentsOfURL: url2!) else { return [hotelData!] }
        
        parser.delegate = self
        
        // XMLのパースを開始
        let success = parser.parse()
        
        if success {
            print("パース成功")
        } else {
            print("パース失敗")
        }
        return hotelDataArray
    }
}

// MARK: - NSXMLParserDelegate

extension ConnectJalan: NSXMLParserDelegate {
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("XML解析開始")
        
    }
    
    /// 解析中に要素の開始タグがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        // nilじゃなければフラグをtrueにして処理をする
        if elementFlgs[elementName] != nil {
            elementFlgs[elementName] = true
        }
        
        // ホテルの開始タグの時にホテル情報を入れるインスタンスを生成(一つのホテルの情報は<Hotel>タグで囲まれている)
        if elementName == "Hotel" {
            hotelData = HotelData()
        }
    }
    
    /// 開始タグと終了タグでくくられたデータがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        guard let guardHoteldata = hotelData else { return }
        for (name, flg) in elementFlgs {
            // フラグがtrueかどうか判定し、その後さらにnameを判定して正しい変数の中に値を入れる
            if flg {
                switch name {
                case "HotelName":
                    guardHoteldata.hotelName = string
                case "Prefecture":
                    guardHoteldata.prefecture = string
                case "LargeArea":
                    guardHoteldata.largeArea = string
                case "HotelCatchCopy":
                    guardHoteldata.hotelCatchCopy = string
                case "PictureURL":
                    guardHoteldata.pictureUrl = string
                case "PlanName":
                    /*
                     閉じタグが来る前に再度この分岐に入ってきた時は前の文字列と合体させる
                     xmlパーサは文字列に数値または記号が入ってきた場合そこで一回文字列を区切って出力する
                     そのため、手動で前の文字列と合体させて出力する必要がある
                    */
                    if planNameFlag {
                        guardHoteldata.planName.append(string)
                        planNameFlag = false
                    } else {
                        guardHoteldata.planName[guardHoteldata.planName.count - 1] = guardHoteldata.planName[guardHoteldata.planName.count - 1] + string
                    }
                case "RoomName":
                    guardHoteldata.roomName.append(string)
                case "PlanDetailURL":
                    if PlanDetailFlag {
                        guardHoteldata.planDetailUrl.append(string)
                        PlanDetailFlag = false
                    } else {
                        guardHoteldata.planDetailUrl[guardHoteldata.planDetailUrl.count - 1] = guardHoteldata.planDetailUrl[guardHoteldata.planDetailUrl.count - 1] + string
                    }
                case "PlanSampleRateFrom":
                    guardHoteldata.planSampleRateFrom.append(string)
                default:
                    break
                }
            }
        }
    }
    
    /// 解析中に要素の終了タグがあったときに実行されるメソッド
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        planNameFlag = true
        PlanDetailFlag = true
        
        // フラグをfalseにして処理を一旦終える
        if elementFlgs[elementName] != nil {
            elementFlgs[elementName] = false
        }
        
        // ホテルの終了タグの時にホテル情報を配列に格納(一つのホテルの情報は<Hotel>タグで囲まれている)
        if elementName == "Hotel" {
            guard let guardhotelData = hotelData else { return }
            hotelDataArray.append(guardhotelData)
        }
    }
    
    /// XML解析終了時に実行されるメソッド
    func parserDidEndDocument(parser: NSXMLParser) {
        print("XML解析終了しました")
    }
    
    /// 解析中にエラーが発生した時に実行されるメソッド
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("エラー:" + parseError.localizedDescription)
    }
}
