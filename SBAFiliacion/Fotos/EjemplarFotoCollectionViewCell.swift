//
//  EjemplarFotoCollectionViewCell.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 15/9/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class EjemplarFotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagen: UIImageView!
    public var caballo:UIImage! {
        didSet {
            imagen.image = caballo
            imagen.layer.masksToBounds = true
            imagen.layer.cornerRadius = 6.0
        }
    }
    
    
    
}


