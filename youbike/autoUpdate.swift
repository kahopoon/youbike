//
//  autoUpdate.swift
//  youbike
//
//  Created by Ka Ho Poon on 12/12/2016.
//  Copyright © 2016 Ka Ho Poon. All rights reserved.
//

import Foundation
import CoreLocation

public struct autoUpdate {
    
    internal static var timer:Timer!
    
    public static func interval(minute: Int) {
        
        settings.sharedInstance.updateInterval = minute
        fireTimerWithNewConfig()
        
    }
    
    public static func with(location: [location]) {
        
        settings.sharedInstance.updateScope = location
        fireTimerWithNewConfig()
        
    }
    
    public static func count(_ value: Int) {
        
        settings.sharedInstance.updateCount = value
        fireTimerWithNewConfig()
        
    }
    
    public static func nearest(_ value: CLLocationCoordinate2D) {
        
        settings.sharedInstance.updateNearest = value
        fireTimerWithNewConfig()
        
    }
    
    public static func isUpdating() -> Bool {
        return settings.sharedInstance.isUpdating
    }
    
    public static func updatedStations() -> [station] {
        return settings.sharedInstance.updatedSations
    }
    
    public static func startUpdating(location:[location] = [.Taoyuan, .Taipei, .NewTaipei, .Taichung], withCount:Int = -1, nearest:CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid, interval:Int = 1) {
        
        autoUpdate.interval(minute: interval)
        autoUpdate.with(location: location)
        autoUpdate.count(withCount)
        autoUpdate.nearest(nearest)
        
        fireTimerWithNewConfig()
    }
    
    public static func stopUpdating() {
        
        timer.invalidate()
        settings.sharedInstance.isUpdating = false
        
    }
    
    internal static func fireTimerWithNewConfig() {
        
        stopUpdating()
        
        timer = Timer.scheduledTimer(withTimeInterval: Double(settings.sharedInstance.updateInterval) * 60, repeats: true, block: { (timer) in
            station.with(locations: settings.sharedInstance.updateScope, withCount: settings.sharedInstance.updateCount, nearest: settings.sharedInstance.updateNearest) { (stations) in
                settings.sharedInstance.updatedSations = stations
            }
        })
        timer.fire()
        
        settings.sharedInstance.isUpdating = true
    }
    
}
