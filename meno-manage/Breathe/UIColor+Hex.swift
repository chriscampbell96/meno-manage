//
//  UIColor+Hex.swift
//  BreatheView
//
//  Created by Chris Campbell on 14/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
