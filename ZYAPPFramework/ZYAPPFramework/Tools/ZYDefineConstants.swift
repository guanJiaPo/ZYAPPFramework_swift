//
//  ZYDefineConstants.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/6.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit

//MARK: - Color

func kRGBColor(r: CGFloat,g: CGFloat,b: CGFloat) -> UIColor {
    return kRGBAColor(r: r, g: g, b: b, a: 1)
}

func kRGBAColor(r: CGFloat,g: CGFloat,b: CGFloat,a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

/// 如：0xaabbcc
func kHexColor(rgb: UInt32) ->UIColor {
    return kHexAColor(rgb: rgb, a: 1)
}

/// 如：0xaabbccdd
func kHexColor(rgba: UInt32) ->UIColor {
    return kRGBAColor(r: (CGFloat((rgba & 0xFF000000) >> 24)), g: (CGFloat((rgba & 0xFF0000) >> 16)), b: (CGFloat((rgba & 0xFF00) >> 8)), a: (CGFloat(rgba & 0xFF)))
}

/// 如：0xaabbcc, 0.5
func kHexAColor(rgb: UInt32, a: CGFloat) -> UIColor {
    return kRGBAColor(r: CGFloat(((rgb)>>16) & 0xFF), g: CGFloat(((rgb)>>8) & 0xFF), b: CGFloat((rgb) & 0xFF), a: a)
}

//MARK: Font

func kFont(size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func kFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: weight)
}

func kBoldFont(size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}


/* DEBUG Print
 *
 * message: 打印消息
 * file: 打印所属类
 * lineNumber: 打印语句所在行数
 */
func ZYPrint(_ items: Any...) {
    #if DEBUG
    let file = #file
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName): \(#line)]- ",items)
    
    #endif
}
