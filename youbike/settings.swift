//
//  singleton.swift
//  youbike
//
//  Created by Ka Ho Poon on 12/12/2016.
//  Copyright © 2016 Ka Ho Poon. All rights reserved.
//

import Foundation
import CoreLocation

internal class settings {
    
    static internal let sharedInstance = settings()
    private init() {}
    
    var isUpdating:Bool!
    var updateInterval:Int!
    var updateScope:[location]!
    var updateCount:Int!
    var updateNearest:CLLocationCoordinate2D!
    var updatedSations:[station]!
    
}
