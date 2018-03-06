//
//  RelaxUICollectionViewCell.swift
//  meno-manage
//
//  Created by Chris Campbell on 27/02/2018.
//  Copyright © 2018 DevChris. All rights reserved.
//

import UIKit

class RelaxUICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!

    
//    var relax: Relax? {
//        didSet{
//            self.updateUI()
//        }
//    }
    
    private func updateUI(){
        if let relax = relax {
            featuredImage.image = relax.featuredImage
            titleLabel.text = relax.title
            backgroundColorView.backgroundColor = relax.color
            
        }else{
            featuredImage.image = nil
            titleLabel.text = nil
            backgroundColorView = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
        self.clipsToBounds = false
    }
}
