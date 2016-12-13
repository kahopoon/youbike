//
//  StationInfo.swift
//  youbike
//
//  Created by Ka Ho Poon on 11/12/2016.
//  Copyright © 2016 Ka Ho Poon. All rights reserved.
//

import Foundation
import CoreLocation

public struct station {
    
    // sno
    public let number:             String
    //lat, lng
    public let location:           CLLocationCoordinate2D
    
    // sna
    public let chineseName:        String
    // sarea
    public let chineseArea:        String
    // ar
    public let chineseAddress:     String
    
    // snaen
    public let englishName:        String
    // sareaen
    public let englishArea:        String
    // aren
    public let englishAddress:     String
    
    // tot
    public let totalLots:          Int
    // sbi
    public let availableForLend:   Int
    // bemp
    public let availableForReturn: Int
    
    // mday
    public let lastUpdateTime:     Date
    // act, sv
    public let active:             Bool
    
    // distance from result of sorting
    public var distance:           Double
    
}
