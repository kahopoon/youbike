//
//  StationExtension.swift
//  youbike
//
//  Created by Ka Ho Poon on 11/12/2016.
//  Copyright © 2016 Ka Ho Poon. All rights reserved.
//

import Foundation
import CoreLocation

internal extension station {
    
    internal init?(json: [String: Any]) {
        
        guard
            let sno     = json["sno"]       as? String,
            let sna     = json["sna"]       as? String,
            let tot     = json["tot"]       as? String,
            let sbi     = json["sbi"]       as? String,
            let sarea   = json["sarea"]     as? String,
            let mday    = json["mday"]      as? String,
            let lat     = json["lat"]       as? String,
            let lng     = json["lng"]       as? String,
            let ar      = json["ar"]        as? String,
            let sareaen = json["sareaen"]   as? String,
            let snaen   = json["snaen"]     as? String,
            let aren    = json["aren"]      as? String,
            let bemp    = json["bemp"]      as? String,
            let act     = json["act"]       as? String
        else {
            return nil
        }
        
        self.number = sno
        self.location = CLLocationCoordinate2DMake(Double(lat) ?? 0, Double(lng) ?? 0)
        
        self.chineseName = sna
        self.chineseArea = sarea
        self.chineseAddress = ar
        
        self.englishName = snaen
        self.englishArea = sareaen
        self.englishAddress = aren
        
        self.totalLots = Int(tot) ?? 0
        self.availableForLend = Int(sbi) ?? 0
        self.availableForReturn = Int(bemp) ?? 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyymmddhhmm"
        self.lastUpdateTime = dateFormatter.date(from: mday) ?? Date()
        self.active = act == "1"
        
        self.distance = -1
    }
    
}
