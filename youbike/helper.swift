//
//  helper.swift
//  youbike
//
//  Created by Ka Ho Poon on 11/12/2016.
//  Copyright © 2016 Ka Ho Poon. All rights reserved.
//

import Foundation
import CoreLocation

internal struct helper {
    
    internal static func sort(stations:[station], withCount:Int, nearest:CLLocationCoordinate2D) -> [station] {
        
        var results:[station]   = []
        let sourcePoint         = CLLocation(latitude: nearest.latitude, longitude: nearest.longitude)

        if CLLocationCoordinate2DIsValid(nearest) {
            
            for station in stations {
                var result = station
                let destinationPoint = CLLocation(latitude: station.location.latitude, longitude: station.location.longitude)
                result.distance = sourcePoint.distance(from: destinationPoint)
                results.append(result)
            }
            
            results = results.sorted { $0.distance < $1.distance }
            return withCount < 0 || withCount > results.count ? results : Array(results.prefix(withCount))
            
        }
        
        return withCount < 0 || withCount > stations.count ? stations : Array(stations.prefix(withCount))
        
    }
    
    internal static func dataFromAPI(url: URL, completion: @escaping (Data?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (Data, URLResponse, Error) in
            
            if Error == nil {
                if  let data = Data {
                    completion(data)
                }
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }

}
