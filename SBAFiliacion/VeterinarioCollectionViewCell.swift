//
//  VeterinarioCollectionViewCell.swift
//  SBAFiliacion
//
//  Created by Lukas on 12/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class VeterinarioCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagen: UIImageView!
    
    public var veterinario:UIImage! {
        didSet {
            imagen.image = veterinario
            imagen.layer.masksToBounds = true
            imagen.layer.cornerRadius = 6.0
        }
    }
}
