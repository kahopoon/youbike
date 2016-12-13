//
//  Get.swift
//  youbike
//
//  Created by Ka Ho Poon on 11/12/2016.
//  Copyright © 2016 Ka Ho Poon. All rights reserved.
//

import Foundation
import CoreLocation

public extension station {
    
    public static func taoyuan(withCount:Int = -1, nearest:CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid, completion: @escaping ([station]) -> Void) {
        
        helper.dataFromAPI(url: url.lovelyTaoyuan!) { (data) in
            var stations:[station] = []
            
            if  let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any],
                let results = json?["result"] as? [String: Any],
                let records = results["records"] as? [Any] {
                
                for record in records {
                    if let Station = record as? [String: Any], let result = station(json: Station) {
                        stations.append(result)
                    }
                }
            }
            completion(helper.sort(stations: stations, withCount: withCount, nearest: nearest))
        }
    }
    
    public static func taipei(withCount:Int = -1, nearest:CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid, completion: @escaping ([station]) -> Void) {
        
        helper.dataFromAPI(url: url.Taipei!) { (data) in
            var stations:[station] = []
            
            if  let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any],
                let results = json?["retVal"] as? [String: Any] {
                
                for (_, value) in results {
                    if let Station = value as? [String: Any], let result = station(json: Station) {
                        stations.append(result)
                    }
                }
            }
            completion(helper.sort(stations: stations, withCount: withCount, nearest: nearest))
        }
    }
    
    public static func newTaipei(withCount:Int = -1, nearest:CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid, completion: @escaping ([station]) -> Void) {
        
        helper.dataFromAPI(url: url.NewTaipei!) { (data) in
            var stations:[station] = []
            
            if  let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [Any],
                let results = json {
                
                for value in results {
                    if let Station = value as? [String: Any], let result = station(json: Station) {
                        stations.append(result)
                    }
                }
            }
            completion(helper.sort(stations: stations, withCount: withCount, nearest: nearest))
        }
    }
    
    public static func taichung(withCount:Int = -1, nearest:CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid, completion: @escaping ([station]) -> Void) {
        
        helper.dataFromAPI(url: url.Taichung!) { (data) in
            var stations:[station] = []
            
            if  let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any],
                let results = json?["retVal"] as? [String: Any] {
                
                for (_, value) in results {
                    if let Station = value as? [String: Any], let result = station(json: Station) {
                        stations.append(result)
                    }
                }
            }
            completion(helper.sort(stations: stations, withCount: withCount, nearest: nearest))
        }
    }
    
    public static func with(locations:[location], withCount:Int = -1, nearest:CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid, completion: @escaping ([station]) -> Void) {
        
        var results:[station] = []
        let task = DispatchGroup()
        
        for location in locations {
            task.enter()
            
            switch location {
            case .Taoyuan:
                station.taoyuan(withCount: withCount, nearest: nearest) { (stations) in
                    results += stations
                    task.leave()
                }
            case .Taipei:
                station.taipei(withCount: withCount, nearest: nearest) { (stations) in
                    results += stations
                    task.leave()
                }
            case .NewTaipei:
                station.newTaipei(withCount: withCount, nearest: nearest) { (stations) in
                    results += stations
                    task.leave()
                }
            case .Taichung:
                station.taichung(withCount: withCount, nearest: nearest) { (stations) in
                    results += stations
                    task.leave()
                }
            }
        }
        
        task.notify(queue: .main) {
            completion(helper.sort(stations: results, withCount: withCount, nearest: nearest))
        }
    }
    
    public static func all(withCount:Int = -1, nearest:CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid, completion: @escaping ([station]) -> Void) {
        
        let allLocation:[location] = [.Taoyuan, .Taipei, .NewTaipei]
        
        station.with(locations: allLocation, withCount: withCount, nearest: nearest) { (stations) in
            completion(helper.sort(stations: stations, withCount: withCount, nearest: nearest))
        }
    }
    
    public static func update(fromStation: station, completion: @escaping (station) -> Void) {
        
        let task = DispatchGroup()
        var results:[station] = []
        
        task.enter()
        station.all { (stations) in
            results = stations
            task.leave()
        }
        
        task.notify(queue: .main) {
            for station in results {
                if station.number == fromStation.number {
                    completion(station)
                }
            }
        }
    }
    
}
