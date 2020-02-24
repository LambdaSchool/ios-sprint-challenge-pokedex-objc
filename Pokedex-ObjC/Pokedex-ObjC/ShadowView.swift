//
//  ShadowView.swift
//  Pokedex-ObjC
//
//  Created by Fabiola S on 2/23/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

import Foundation
import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform:  nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.9, height: 0.50)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 25
        
        layer.cornerRadius = 25
    }
}

