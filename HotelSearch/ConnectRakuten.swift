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
    
    // MARK: - スタティック関数
    
    /// お勧めのホテルのデータを取ってくる
    func connectRecommendHotel() -> [HotelData] {
        
        let url = NSURL(string: "https://app.rakuten.co.jp/services/api/Travel/VacantHotelSearch/20131024?applicationId=\(APIKey)&format=json&largeClassCode=\(country)&middleClassCode=\(prefectures)&smallClassCode=\(district)&detailClassCode=\(detailDistrict)&hits=\(count)&sort=\(order)")
        
        guard let guardUrl = url else { return [HotelData()] }
        Alamofire.request(.GET, guardUrl).responseJSON { response in
            
            guard let object = response.result.value else { return }
            let json = JSON(object)
            self.setJSON(json)
        }
        return [HotelData()]
    }
    
    // MARK: - プライベート関数
    
    private func setJSON(json: JSON) {
        for i in 0 ..< json["hotels"].count {
            print("koko")
            print(json["hotels"][i]["hotel"][0]["hotelBasicInfo"]["hotelName"].stringValue)
            print(json["hotels"][i]["hotel"][1]["roomInfo"][0]["roomBasicInfo"]["planName"].stringValue)
        }
    }
}
