//
//  Extension.swift
//  SmartMechanic
//
//  Created by Waleed Waheed Khan on 31/07/2018.
//  Copyright © 2018 Xint Solutions. All rights reserved.
//

import UIKit

extension String {
    func stringToDate(type:Int) -> Date{
        let formatter = DateFormatter()
        if(type == 1)
        {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        else if(type == 2)
        {
            formatter.dateFormat = "dd-MM-yyyy"
        }
        else if(type == 3)
        {
            formatter.dateFormat = "yyyy-MM-dd"
        }
        else
        {
            formatter.dateFormat = "MM/dd/yyyy"
        }
        return formatter.date(from: self)!
    }
}

extension Date
{
    func dateToString(type:Int) -> String{
        let formatter = DateFormatter()
        if(type == 1)
        {
            formatter.dateFormat = "dd/MM/yyyy hh:mm a"
        }
        else if(type == 2)
        {
            formatter.dateFormat = "dd-MM-yyyy"
        }
        else
        {
            formatter.dateFormat = "MM/dd/yyyy"
        }
        return formatter.string(from: self)
    }
}

extension UIView {
    func animateLayOutSetting()
    {
        UIView.animate(withDuration: 0.3, animations:
            {
                self.layoutIfNeeded()
        })
    }
    func circle()
    {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    func borderColor(color:UIColor)  {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCornor(cornerRadius:CGFloat)
    {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    func txtFieldRoundCorner()
    {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    func chatFieldRound()
    {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(NSURL(string: url)! as URL) {
                application.openURL(NSURL(string: url)! as URL)
                return
            }
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIColor {
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UITextField{
    func setPadding(width:CGFloat) {
        let paddingView = UIView(frame: CGRect(x:0,y:0,width:width,height:self.frame.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font : font], context: nil)
        return boundingBox.height
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Calendar {
    func isDateInYesterdayTodayTomorrow(_ date: Date) -> Bool
    {
        return self.isDateInYesterday(date) || self.isDateInToday(date) || self.isDateInTomorrow(date)
    }
}

func relativeDateString(for date: Date, locale : Locale = Locale.current) -> String
{
    let dayFormatter = DateFormatter()
    dayFormatter.locale = locale
    if Calendar.current.isDateInYesterdayTodayTomorrow(date) {
        dayFormatter.dateStyle = .medium
        dayFormatter.doesRelativeDateFormatting = true
    } else {
        dayFormatter.dateFormat = "EEEE"
    }
    let relativeWeekday = dayFormatter.string(from: date)
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = locale
    dateFormatter.dateFormat = "d MMMM"
    return  relativeWeekday + ", " + dateFormatter.string(from: date)
}

