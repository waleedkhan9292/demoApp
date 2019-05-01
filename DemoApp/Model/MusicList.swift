//
//  MusicList.swift
//  DemoApp
//
//  Created by Macbook Pro on 30/04/2019.
//  Copyright © 2019 Waleed Waheed Khan. All rights reserved.
//

import UIKit

class MusicList: NSObject {
    
    static var sharedInstance = MusicList()
    
    var id = ""
    var artistName = ""
    var releaseDate = ""
    var name = ""
    var mediaType = ""
    var pic:URL? = URL.init(string: placeHolderImage)
    
    var serviceDescription = ""
    
    func load(data: [String: AnyObject]) -> Void {
        
        if let value = data["artistName"] as? String {
            artistName = value;
        }
        if let value = data["id"] as? String {
            id = value
        }
        if let value = data["releaseDate"] as? String {
            releaseDate = value
        }
        if let value = data["name"] as? String {
            name = value
        }
        if let value = data["artworkUrl100"] as? String {
            pic = URL.init(string: value)
        }
        if let value = data["kind"] as? String {
            mediaType = value
        }
        
    }

    func saveMusicData(data: [String: AnyObject]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            let jsonString = String(data: jsonData, encoding: .utf8)
            CommonMethod.setValueInUserDefault(key: String(describing:MusicList.self), value: jsonString!)
        } catch {
            print(error.localizedDescription)
        }
    }
    func loadLocalHistoryData() -> [MusicList]
    {
        var musicList:[MusicList] = [MusicList]()
        do {
            let object = CommonMethod.getValueFromUserDefault(key: "MusicList")
            if(object != nil)
            {
                let jsonString = object as! String
                if(!jsonString.isEmpty)
                {
                    let jsonData = jsonString.data(using: .utf8)
                    let decoded = try JSONSerialization.jsonObject(with: jsonData!, options: [])
                    
                    let res = decoded as? [String:AnyObject]
                    if let data = res!["feed"] as? [String: AnyObject] {
                        if let dataList = data["results"] as? [[String:AnyObject]] {
                            for data in dataList {
                                let music = MusicList()
                                MusicList.sharedInstance.load(data: data)
                                music.load(data: data);
                                musicList.append(music)
                            }
                        }
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return musicList
    }
    
    static func reset() {
        CommonMethod.setValueInUserDefault(key: String(describing: MusicList.self), value: "")
        sharedInstance = MusicList()
    }
}
