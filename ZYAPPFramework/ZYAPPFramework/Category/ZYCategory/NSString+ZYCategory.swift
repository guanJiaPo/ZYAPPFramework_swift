//
//  NSStringCategory.swift
//  UESwift
//
//  Created by 石志愿 on 2018/3/2.
//  Copyright © 2018年 石志愿. All rights reserved.
//

import UIKit

extension NSString {
    
    class func md5String(str: String) -> String {
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
    /// 字符串是否为空
    static func isEmpty(string : Any?) -> Bool {
        guard let str = string as? String else {
          return true
        }
        
        if str.count == 0 || str == "" || str == "null" || str == "(null)" {
            return true
        }
        return false
    }
    
    func sizeWithFont(font: UIFont, maxSize: CGSize) -> CGSize {
        if String.isEmpty(string: self) {
            return CGSize.zero
        }
        let size = self.boundingRect(with: maxSize, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size
        return size
    }
    
    func zy_subString(to index: Int) -> String {
        if self.count > 0 {
            return String(self[..<self.index(self.startIndex, offsetBy: index)])
        }else{
            return self
        }
    }
    
    func zy_subString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    func zy_subString(rang: NSRange) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: rang.location)
        let endIndex = self.index(self.startIndex, offsetBy: (rang.location + rang.length))
        return String(self[startIndex..<endIndex])
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
    
    static func md5String(str: String) -> String {
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
    
    /// 是否为手机号(模糊匹配)
    func isPhoneNum() -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        let regex = "1[0-9][0-9]{9}";
        return self.predicate(with: regex)
    }
    
    /// 是否为邮箱
    func isEmail() -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        return self.predicate(with: regex)
    }
    
    /// 是否为身份证号码
    func isIdCard() -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
    
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$";
        return self.predicate(with: regex)
    }
    
    /// 是否为纯数字
    func isPureNumber() -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        let regex = "[0-9]*";
        return self.predicate(with: regex)
    }
    
    /// 是否为纯字母
    func isPureLetters() -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        let regex = "[a-zA-Z]*";
        return self.predicate(with: regex)
    }
    
    /// 只包含数字和字母
    func isPureNumberOrLetters() -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        let regex = "[a-zA-Z0-9]*";
        return self.predicate(with: regex)
    }
    
    /// 只包含数字和.
    func isPureNumbersOrPoint() -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        let regex = "[0-9.]*";
        return self.predicate(with: regex)
    }
    
    /// 只包含中文
    func isPureChinese(string: String) -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        let regex = "[\u{4e00}-\u{9fa5}]+"
        return self.predicate(with: regex)
    }
    
    /// 是否包含中文
    func isContainsChinese() -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        
        for value in self {
            if ("\u{4E00}" <= value && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    /// n-m位数字和字母组合
    func checkNumOrLetStrForN(n: Int, to m: Int) -> Bool {
        if String.isEmpty(string: self) {
            return false
        }
        let regx = NSString(format: "^[A-Za-z0-9]{%td,%td}+$", min(n, m), max(n, m)) as String
        return self.predicate(with: regx)
    }
    
    /// 拼音
    func pinYin() -> String {
        if String.isEmpty(string: self) {
            return ""
        }
        //转化为可变字符串
        let mString = NSMutableString(string: self)
        //转化为带声调的拼音
        CFStringTransform(mString, nil, kCFStringTransformToLatin, false)
        //转化为不带声调
        CFStringTransform(mString, nil, kCFStringTransformStripDiacritics, false)
        
        //转化为不可变字符串
        let string = NSString(string: mString)
        //去除字符串之间的空格
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    /// 首字母
    func firstLetter() -> String {
        let pinYin = self.pinYin()
        if !String.isEmpty(string: pinYin) {
            let first = pinYin.zy_subString(rang: NSRange(location: 0, length: 1))
            if first.isPureLetters() {
                return first.uppercased()
            }
            return "#"
        }
        return "#"
    }
    
    /// Range转NSRange
    func toNSRange(_ range: Range<String.Index>) -> NSRange {
        guard let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) else {
            return NSMakeRange(0, 0)
        }
        return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
    }
    /// NSRange转Range
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
}

extension String {
    //MARK: private method
    /// 正则匹配
    fileprivate func predicate(with regex: String) -> Bool{
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
