//
//  ConnectRakuten.swift
//  HotelSearch
//
//  Created by 青木孝乃輔 on 2016/11/01.
//  Copyright © 2016年 青木孝乃輔. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

final class ConnectRakuten: NSObject {
    
    // MARK: - 定数プロパティ
    
    /// APIKey
    private let APIKey = "1083005176773598352"
    
    /// 表示件数
    private let count = 5
    
    /// 表示の並び順
    private let order = "standard"
    
    /// 国
    private let country = "japan"
    
    /// 都道府県
    private let prefectures = "tokyo"
    
    /// 地区
    private let district = "tokyo"
    
    /// 詳細地区
    private let detailDistrict = "A"
    
    /// HotelDataを格納する配列
    private var hotelDataArray = [HotelData]()
    
    /// お勧めのホテルのデータを取ってくる
    func connectRecommendHotel() -> [HotelData] {
        
        //ロックの取得
        var keepAlive = true
        
        let url = NSURL(string: "https://app.rakuten.co.jp/services/api/Travel/VacantHotelSearch/20131024?applicationId=\(APIKey)&format=json&largeClassCode=\(country)&middleClassCode=\(prefectures)&smallClassCode=\(district)&detailClassCode=\(detailDistrict)&hits=\(count)&sort=\(order)")
        
        guard let guardUrl = url else { return [HotelData()] }
        
        Alamofire.request(.GET, guardUrl).responseJSON { response in
            guard let object = response.result.value else { return }
            let json = JSON(object)
            self.setJSON(json)
            
            //ロックの解除
            keepAlive = false
        }
        
        //ロックが解除されるまで待つ
        let runLoop = NSRunLoop.currentRunLoop()
        while keepAlive && runLoop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {
            // 0.1秒毎の処理なので、処理が止まらない
        }
        
        return hotelDataArray
    }
    
    // MARK: - プライベート関数
    
    /// HotelDataの値をHotelDataArrayに入れる
    private func setJSON(json: JSON) {
        
        for i in 0 ..< json["hotels"].count {
            let hotelData = HotelData()
            hotelData.hotelName = json["hotels"][i]["hotel"][0]["hotelBasicInfo"]["hotelName"].stringValue
            hotelData.prefecture = json["hotels"][i]["hotel"][0]["hotelBasicInfo"]["address1"].stringValue
            hotelData.largeArea = json["hotels"][i]["hotel"][0]["hotelBasicInfo"]["nearestStation"].stringValue
            hotelData.hotelCatchCopy = json["hotels"][i]["hotel"][0]["hotelBasicInfo"]["hotelSpecial"].stringValue
            hotelData.pictureUrl = json["hotels"][i]["hotel"][0]["hotelBasicInfo"]["hotelImageUrl"].stringValue
            
            for j in 0 ..< json["hotels"][i]["hotel"][1]["roomInfo"].count {
                hotelData.planName.append(json["hotels"][i]["hotel"][j + 1]["roomInfo"][0]["roomBasicInfo"]["planName"].stringValue)
                hotelData.roomName.append(json["hotels"][i]["hotel"][j + 1]["roomInfo"][0]["roomBasicInfo"]["roomName"].stringValue)
                hotelData.planDetailUrl.append(json["hotels"][i]["hotel"][j + 1]["roomInfo"][0]["roomBasicInfo"]["reserveUrl"].stringValue)
                hotelData.planSampleRateFrom.append(json["hotels"][i]["hotel"][j + 1]["roomInfo"][1]["dailyCharge"]["total"].stringValue)
            }
            hotelDataArray.append(hotelData)
        }
    }
}
