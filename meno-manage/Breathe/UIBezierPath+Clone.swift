//
//  UIBezierPath+Clone.swift
//  BreatheView
//
//  Created by Chris Campbell on 14/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//
import UIKit

extension UIBezierPath {
    func clone() -> UIBezierPath {
        let path = UIBezierPath()
        path.append(self)
        return path
    }
}
