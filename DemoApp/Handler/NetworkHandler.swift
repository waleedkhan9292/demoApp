//
//  NetworkHandler.swift
//  SmartMechanic
//
//  Created by Waleed Waheed Khan on 31/07/2018.
//  Copyright © 2018 Xint Solutions. All rights reserved.
//

import UIKit
import Alamofire

class NetworkHandler: NSObject {

    static var baseURL:String = "https://rss.itunes.apple.com/"
    static var baseURL_API:String = baseURL+"api/v1/"
    
    static func getImageUrlWithBase(image:String) -> String
    {
        return baseURL+image;
    }
    static func getVideoUrlWithBase(video:String) -> String
    {
        return baseURL+video;
    }
    
    static func postDataWithImage(view:UIViewController,url: String, sendData:Parameters, completion: @escaping(Bool, AnyObject?)  ->  Swift.Void)
    {
        
        let data:Parameters = sendData ;
        
        let cURL:String = baseURL_API+url;
        
        let headers = [
            "Accept": "application/json"
        ]
        
        print("SendURL: \(cURL)", terminator: "");
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                for (key, value) in data
                {
                    if(key == "image")
                    {
                        if  let imageData = (value as! UIImage).jpegData(compressionQuality: 0.5) {
                            multipartFormData.append(imageData, withName: key, fileName: "file.jpeg", mimeType: "image/jpeg")
                        }
                    }
                    else
                    {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                }
                
        },
            to: cURL,
            method:.post,
            headers:headers,
            encodingCompletion: {
                encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON {
                        response in
                        switch response.result {
                        case .success(let JSON):
                            
                            print("responseData: \(JSON)");
                            let response = JSON as! [String:AnyObject]
                            let status:Bool = response["success"] as! Bool;
                            
                            if (status)
                            {
                                completion(true,response as AnyObject);
                            }
                            else
                            {
                                if let errors = response["errors"] as? [String]
                                {
                                    if(errors.count > 0)
                                    {
                                        let message:String = errors[0]
                                        CommonMethod.showErrorAlertView(title:"Error", description: message,view:view);
                                    }
                                }
                                completion(false,nil);
                            }
                            break;
                        case .failure(let error):
                            
                            CommonMethod.showErrorAlertView(title: "Error", description: error.localizedDescription,view:view);
                            completion(false,nil);
                            break;
                        }
                    }
                    break
                case .failure(let encodingError):
                    CommonMethod.showErrorAlertView(title: "Error", description: ((encodingError as Error) as NSError).localizedDescription,view:view);
                    completion(false,nil);
                    break
                }
        }
        )
        
    }
    
    
    static func getData(view:UIViewController?,url: String,completion:@escaping(Bool, AnyObject?) ->  Swift.Void)
    {
        let cURL:String = baseURL_API+url;
        
        let headers = [
            "Accept": "application/json"
        ]
        
        print("SendURL: \(cURL)", terminator: "");
        Alamofire.request(cURL,method: .get,headers:headers).validate().responseJSON {
            
            response in
            switch response.result {
            case .success(let JSON):
                
                print("responseData: \(JSON)");
                let response = JSON as! [String:AnyObject]
//                let status:Bool = response["result"] as! Bool;
                
                completion(true,response as AnyObject);
//                if (status)
//                {
//                }
//                else
//                {
//                    if let errors = response["errors"] as? [String]
//                    {
//                        if(errors.count > 0)
//                        {
//                            let message:String = errors[0]
//                            if view != nil {
//                                CommonMethod.showErrorAlertView(title:"Error", description: message,view:view!);
//                            }
//
//                        }
//                    }
//                    completion(false,nil);
//                }
                break;
            case .failure(let error):
                
                if view != nil {
                    CommonMethod.showErrorAlertView(title: "Error", description: error.localizedDescription,view:view!);
                }
                completion(false,nil);
                break;
            }
            
        }
    }
}
