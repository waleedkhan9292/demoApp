//
//  CommonMethod.swift
//  SmartMechanic
//
//  Created by Waleed Waheed Khan on 31/07/2018.
//  Copyright © 2018 Xint Solutions. All rights reserved.
//

import UIKit

class CommonMethod: NSObject {
    
    static func showErrorAlertView(title:String, description:String, view:UIViewController) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: description,
                                      preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "OK",
                                          style: .default) {(_) in
                                            // your defaultButton action goes here
        }
        
        alert.addAction(defaultButton)
        view.present(alert, animated: true) {
            // completion goes here
        }
    }
    
    static func isValidEmail(email:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func setValueInUserDefault(key:String, value:String)
    {
        let defaults = UserDefaults.standard;
        defaults.setValue(value, forKey: key);
        defaults.synchronize();
    }
    
    static func getValueFromUserDefault(key:String) -> AnyObject?
    {
        let defaults = UserDefaults.standard;
        if(defaults.value(forKey: key) != nil)
        {
            return defaults.value(forKey: key) as AnyObject;
        }
        return nil
    }
    
    static func removeValueFromUserDefault(key:String)
    {
        let defaults = UserDefaults.standard;
        defaults.removeObject(forKey: key);
        defaults.synchronize();
    }
    
    static func removeAllValuesFromUserDefault()
    {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    static func swipeRightToLeft(view:UIView)
    {
        let screenRect = UIScreen.main.bounds
        // Animate the transition.
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            view.frame = CGRect(x:-screenRect.size.width, y:view.frame.origin.y, width:view.frame.size.width,height:view.frame.size.height)
        }) { (Finished) -> Void in
            view.alpha=0
        }
    }
    
    static func swipeLeftToRight(view:UIView)
    {
        let screenRect = UIScreen.main.bounds
        view.frame = CGRect(x:-screenRect.size.width, y:view.frame.origin.y, width:view.frame.size.width,height:view.frame.size.height)
        // Animate the transition.
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            view.frame = CGRect(x:0, y:view.frame.origin.y, width:view.frame.size.width,height:view.frame.size.height)
        }) { (Finished) -> Void in
        }
    }
    
    static func fadeIn(view:UIView)
    {
        view.alpha=0
        // Animate the transition.
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            view.alpha=1
        }) { (Finished) -> Void in
        }
    }
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
