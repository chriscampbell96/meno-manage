//
//  CGPoint+Hashable.swift
//  BreatheView
//
//  Created by Chris Campbell on 14/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

/* Extending CGPoint to be Hashable
 * more: https://stackoverflow.com/questions/32988665/is-there-a-specific-way-to-use-tuples-as-set-elements-in-swift
 */
extension CGPoint: Hashable {
    public var hashValue: Int {
        return (x.hashValue << MemoryLayout<CGFloat>.size) ^ y.hashValue
    }
}
