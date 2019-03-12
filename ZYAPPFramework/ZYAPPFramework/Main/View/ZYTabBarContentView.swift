//
//  ZYTabBarContentView.swift
//  ZYAPPFramework
//
//  Created by 石志愿 on 2019/3/6.
//  Copyright © 2019 石志愿. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class ZYTabBarContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = kHexColor(rgb: 0x9092a5)
        iconColor = kHexColor(rgb: 0x9092a5)
        highlightTextColor = kHexColor(rgb: 0x4A6AFF)
        highlightIconColor = kHexColor(rgb: 0x4A6AFF)
        titleLabel.font = kFont(size: 11)
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
