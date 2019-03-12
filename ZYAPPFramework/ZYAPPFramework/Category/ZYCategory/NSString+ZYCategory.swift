//
//  NSStringCategory.swift
//  UESwift
//
//  Created by 石志愿 on 2018/3/2.
//  Copyright © 2018年 石志愿. All rights reserved.
//

import UIKit

extension NSString {
    
    class func md5String(str:String) ->String {
        let cStr = str.cString(using: .utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    func sizeWithFont(font: UIFont, maxSize: CGSize) -> CGSize {
        let size = self.boundingRect(with: maxSize, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size
        return size
    }
}

extension String {
    
    func sizeWithFont(font: UIFont, maxSize: CGSize) -> CGSize {
        let size = self.boundingRect(with: maxSize, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size
        return size
    }
    
    /// 字典/数组转二进制
    static func toJSONData(object: Any) -> Data? {
        if (!JSONSerialization.isValidJSONObject(object)) {
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
        return data
        
    }
    /// 字典/数组转JSON
    static func toJSONString(object: Any) -> String? {
        if let data = toJSONData(object: object) {
            let JSONString = String(data: data, encoding: String.Encoding.utf8)
            return JSONString as String?
        }
        return nil
    }
    
    static func md5String(str:String) ->String {
        let cStr = str.cString(using: .utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    /// url中文及特殊字符转码
    static func urlEncode(string : String) -> String {
        let charactersToEscape = "!$&'()*+,-./:;=?@_~%#[]"
        let allowedCharacters = NSCharacterSet(charactersIn: charactersToEscape).inverted
        let encodedString = string.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
        return encodedString ?? string;
    }
    
    /// 只包含字母和数字的随机字符串
    static func arc4randomString(with length: Int) -> String {
        let letterString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numberString = "0123456789"
        var randomString = ""
        
        for i in 0 ..< length {
            var slicingString: String
            if i <= length / 2 {
                slicingString = letterString
            } else {
                slicingString = numberString
            }
            let index = Int(arc4random() % UInt32(slicingString.count))
            if let c = slicingString.prefix(index).last {
                randomString += String(c)
            }
        }
        
        return randomString
    }
}


