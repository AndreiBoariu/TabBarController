//
//  Utils.swift
//  Mumo
//
//  Created by Beny Boariu on 24/02/15.
//  Copyright (c) 2015 Mumo. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    // MARK: - Public Methods
    /// Simply load image async
    class func displayImage(imgToDisplay: UIImage?,
        forImageView imageView: UIImageView,
        withRoundCorners roundCorners: Bool,
        withBorderWidth borderWidth: CGFloat!,
        andBorderColor borderColor: UIColor?) {
            
        let queue : dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, { () -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //=>    Set image
                imageView.image     = imgToDisplay
                
                if roundCorners == true {
                    //=>    Set round corners
                    imageView.layer.cornerRadius      = imageView.frame.size.height / 2
                    imageView.layer.masksToBounds     = true
                }
                
                if borderWidth > 0 {
                    imageView.layer.borderWidth = borderWidth
                    if let borderColorTemp = borderColor {
                        imageView.layer.borderColor = borderColorTemp.CGColor
                    }
                }
            })
        });
    }
    
    /// Simply load image async, from URL
    class func displayImageFromURL(urlImage: NSURL!,
        forImageView imageView: UIImageView,
        withRoundCorners roundCorners: Bool,
        withBorderWidth borderWidth: CGFloat!,
        andBorderColor borderColor: UIColor?) {
            
            let queue : dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            dispatch_async(queue, { () -> Void in
                
                if let dataProfileImage = NSData(contentsOfURL: urlImage) {
                    if let imgToDisplay = UIImage(data: dataProfileImage) {
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            //=>    Set image
                            imageView.image     = imgToDisplay
                            
                            //=>    Set round corners
                            if roundCorners == true {
                                imageView.layer.cornerRadius      = imageView.frame.size.height / 2
                                imageView.layer.masksToBounds     = true
                            }
                            
                            //=>    Set border width and color
                            if borderWidth > 0 {
                                imageView.layer.borderWidth = borderWidth
                                if let borderColorTemp = borderColor {
                                    imageView.layer.borderColor = borderColorTemp.CGColor
                                }
                            }
                        })
                    }
                }
            })
    }
    
    /// Simply load image async, from URL, with completion
    class func displayImageFromURL(urlImage: NSURL!,
        forImageView imageView: UIImageView,
        withRoundCorners roundCorners: Bool,
        withBorderWidth borderWidth: CGFloat!,
        andBorderColor borderColor: UIColor?,
        withCompletion completion:(imageFromURL: UIImage?) -> Void) {
            
            let queue : dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            dispatch_async(queue, { () -> Void in
                
                if let dataProfileImage = NSData(contentsOfURL: urlImage) {
                    if let imgToDisplay = UIImage(data: dataProfileImage) {
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            //=>    Set image
                            imageView.image     = imgToDisplay
                            completion(imageFromURL: imgToDisplay)
                            
                            //=>    Set round corners
                            if roundCorners == true {
                                imageView.layer.cornerRadius      = imageView.frame.size.height / 2
                                imageView.layer.masksToBounds     = true
                            }
                            
                            //=>    Set border width and color
                            if borderWidth > 0 {
                                imageView.layer.borderWidth = borderWidth
                                if let borderColorTemp = borderColor {
                                    imageView.layer.borderColor = borderColorTemp.CGColor
                                }
                            }
                        })
                    }
                    else {
                        completion(imageFromURL: nil)
                    }
                }
            })
    }
}

// MARK: - EXTENSIONS Methods

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext() as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension Array
{
    func contains<T where T : Equatable>(obj: T) -> Bool
    {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
    mutating func removeObject<U: Equatable>(object: U)
    {
        var index: Int?
        for (idx, objectToCompare) in enumerate(self)
        {
            if let to = objectToCompare as? U
            {
                if object == to
                {
                    index = idx
                }
            }
        }
        
        if(index != nil)
        {
            self.removeAtIndex(index!)
        }
    }
}

extension NSTimeInterval {
    
    /// Get the total amount of hours that this Time Interval instance holds
    var hours: Int {
        return Int(floor(((self / 60.0) / 60.0)))
    }
    /// Get the hour component, up to 23 hours
    public var hourComponent: Int {
        return self.hours % 24
    }
    /// Get the total amount of minutes that this Time Interval instance holds
    var minutes: Int {
        return Int(floor(self / 60.0))
    }
    /// Get the minutes component, up to 59 minutes
    public var minuteComponent: Int {
        return minutes - (hours * 60)
    }
    /// Get the total amount of seconds that this Time Interval instance holds
    var seconds: Int {
        return Int(floor(self))
    }
    /// Get the seconds component, up to 59 seconds
    public var secondComponent: Int {
        return seconds - (minutes * 60)
    }
    /// Get the total amount of miliseconds that this Time Interval instance holds
    var miliseconds: Int64 {
        return Int64((seconds * 1000) + milisecondComponent)
    }
    /// Get the miliseconds component
    public var milisecondComponent: Int {
        var (intPart, fracPart) = modf(self)
        return Int(fracPart * 100)
    }
    
    ///
    /// Get this NSTimeInterval instance as a formatted string
    /// :param: useFraction Optionally appends the miliseconds to the string
    ///
    public func getFormattedInterval(miliseconds useFraction: Bool) -> String {
        let hoursStr = hourComponent < 10 ? "0" + String(hourComponent) : String(hourComponent)
        let minutesStr = minuteComponent < 10 ? "0" + String(minuteComponent) : String(minuteComponent)
        let secondsStr = secondComponent < 10 ? "0" + String(secondComponent) : String(secondComponent)
        var counter = "\(hoursStr):\(minutesStr):\(secondsStr)"
        
        if useFraction {
            let milisecondsStr = milisecondComponent < 10 ? "0" + String(milisecondComponent) : String(milisecondComponent)
            counter += ".\(milisecondsStr)"
        }
        
        return counter
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
    
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur++
        }
        return nil
    }
    
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
