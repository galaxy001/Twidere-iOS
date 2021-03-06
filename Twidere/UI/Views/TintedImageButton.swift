//
//  TintedImageButton.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

@IBDesignable
class TintedImageButton: UIButton {
    
    @IBInspectable
    var templateImage: UIImage! {
        didSet {
            let template = templateImage.withRenderingMode(.alwaysTemplate)
            self.setImage(template, for: .normal)
        }
    }
    
}
