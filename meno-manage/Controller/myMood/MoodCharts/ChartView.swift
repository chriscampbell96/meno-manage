//
//  ChartView.swift
//  meno-manage
//
//  Created by Chris Campbell on 09/03/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class ChartView: UIView {

    @IBOutlet var veiw: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "monthlyviewcount", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(veiw)
        veiw.frame = self.bounds
    }
}
