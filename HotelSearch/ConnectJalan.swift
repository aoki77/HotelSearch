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
    private let count = 10
    
    /// 表示の並び順
    private let order = 4
    
    /// 都道府県番号
    private let prefectures = 120000
    
    // MARK: - 変数プロパティ
    
    private var hotelData: HotelData?
    
    private var hotelDataArray = [HotelData]()
    
    private var planNameFlag = true
    
    private var PlanDetailFlag = true
    
    /// それぞれのタグのフラグ(key名はタグ名と同一)
    private var elementFlgs = ["HotelID": false, "HotelName": false, "Prefecture": false, "LargeArea": false, "HotelType": false, "HotelCatchCopy": false, "PictureURL": false, "PlanName": false, "RoomName": false, "PlanDetailURL": false, "PlanSampleRateFrom": false ]
    
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
        for (name, flg) in elementFlgs {
            // フラグがtrueかどうか判定し、その後さらにnameを判定して正しい変数の中に値を入れる
            if flg {
                switch name {
                case "HotelID":
                    hotelData!.hotelId = string
                case "HotelName":
                    hotelData!.hotelName = string
                case "Prefecture":
                    hotelData!.prefecture = string
                case "LargeArea":
                    hotelData!.largeArea = string
                case "HotelType":
                    hotelData!.hotelType = string
                case "HotelCatchCopy":
                    hotelData!.hotelCatchCopy = string
                case "PictureURL":
                    hotelData!.pictureUrl = string
                case "PlanName":
                    if planNameFlag {
                        hotelData!.planName.append(string)
                        planNameFlag = false
                    } else {
                        hotelData!.planName[hotelData!.planName.count - 1] = hotelData!.planName[hotelData!.planName.count - 1] + string
                    }
                case "RoomName":
                    hotelData!.roomName.append(string)
                case "PlanDetailURL":
                    if PlanDetailFlag {
                        hotelData!.planDetailUrl.append(string)
                        PlanDetailFlag = false
                    } else {
                        hotelData!.planDetailUrl[hotelData!.planDetailUrl.count - 1] = hotelData!.planDetailUrl[hotelData!.planDetailUrl.count - 1] + string
                    }
                case "PlanSampleRateFrom":
                    hotelData!.planSampleRateFrom.append(string)
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
