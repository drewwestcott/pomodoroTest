//
//  UIViewExtensions.swift
//  FocusMinder
//
//  Created by Drew Westcott on 13/05/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(hue: SHADOW_COLOR, saturation: SHADOW_COLOR, brightness: SHADOW_COLOR, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
    }

}
