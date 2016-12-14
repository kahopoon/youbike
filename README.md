# youbike for iOS project
You can now get the youbike realtime info in a very easy way.
According to available open data from TW Gov, for now, support cities are: Taipei, New Taipei, Taoyuan, Taichung.

## Installation
### Cocoapods
```swift
pod 'youbike'
```
### At xcode project
```swift
import youbike
```
At Info.plist, add these urls to 'Exception Domains' at 'App Transport Security Settings'
```
data.tycg.gov.tw
data.taipei
data.ntpc.gov.tw
ybjson01.youbike.com.tw:1002
```

## Usage
### Get all station
```swift
youbike.station.all { (stations) in
    // all stations array
}
```
### Specific city
```swift
youbike.station.taoyuan { (stations) in
    // taoyuan stations array
}
```
### Specific cities
```swift
youbike.station.with(locations: [.Taipei, .Taoyuan]) { (stations) in
    // taipei and taoyuan stations array    
}
```
## Search nearest / result limit
```swift
let taoyuanArena = CLLocationCoordinate2D(latitude: 24.9950114,longitude: 121.3229133)
youbike.station.all(withCount: 5, nearest: taoyuanArena) { (stations) in
    // 5 result that near taoyuan arena
}
```
```swift
youbike.station.taoyuan(withCount: 5, nearest: taoyuanArena) { (stations) in
    // as same as previous one ideally...:p
}
```
```swift
youbike.station.taoyuan(nearest: taoyuanArena) { (stations) in
    // all taoyuan stations sorted with taoyuan arena
}
```
```swift
youbike.station.taoyuan(nearest: taoyuanArena) { (stations) in
    // all stations sorted with taoyuan arena
}
```
### Station update
```swift
youbike.station.update(fromStation: <#station#>) { (station) in
    // update for station
}
```

## Auto Update
### Start fetch
```swift
youbike.autoUpdate.startUpdating()
```
### Updated result (default: per minute, all stations)
```swift
youbike.autoUpdate.updatedStations()
```
### Stop fetch
```swift
youbike.autoUpdate.stopUpdating()
```
## Auto Update Settings
### Location based limit result
```swift
youbike.autoUpdate.startUpdating(location: [.Taoyuan], withCount: 3, nearest: taoyuanArena, interval: 2) //3 result near taoyuan arena at taoyuan, update every 2 mins
```
### Change settings while updating
```swift
youbike.autoUpdate.count(5) // set result limit to 5
```
```swift
youbike.autoUpdate.interval(minute: 5) // set update interval to 5 mins
```
```swift
youbike.autoUpdate.nearest(CLLocationCoordinate2D) // set nearest location
```
```swift
youbike.autoUpdate.with(location: [location]) // set cities
```
