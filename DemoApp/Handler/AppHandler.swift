//
//  AppHandler.swift
//  SmartMechanic
//
//  Created by Waleed Waheed Khan on 31/07/2018.
//  Copyright © 2018 Xint Solutions. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class AppHandler: NSObject {
    
    //MARK : - Get Requests
    static func getMusicList(
        subUrl:String,
        view:UIViewController,
        completion: @escaping(Bool,[MusicList]) -> Swift.Void
        ) {
        SVProgressHUD.show()
        NetworkHandler.getData(view:view,url:subUrl) {
            (status:Bool,result: AnyObject?) in
            SVProgressHUD.dismiss()
            var musicList:[MusicList] = [MusicList]()
            if(status) {
                SVProgressHUD.dismiss()
                let res = result as! [String:AnyObject]
//                MusicList.sharedInstance.saveMusicData(data: res)
//                MusicList.sharedInstance.load(data: res)
                if let data = res["feed"] as? [String: AnyObject] {
                    if let dataList = data["results"] as? [[String:AnyObject]] {
                        for data in dataList {
                            let music = MusicList()
                            music.load(data: data)
                            musicList.append(music)
                        }
                    }
                }
                completion(true,musicList)
            }
            else {
                completion(false, musicList)
            }
        }
    }
    
}
