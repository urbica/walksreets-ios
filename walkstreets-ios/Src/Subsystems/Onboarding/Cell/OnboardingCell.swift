//
//  OnboardingCell.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 02/06/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var onboardingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupImageView(image: UIImage) {
        onboardingImageView.image = image
    }
    
    func showContinue() {
        
    }
}
