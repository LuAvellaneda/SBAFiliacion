//
//  EjemplarFichaCollectionViewCell.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 15/9/18.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class EjemplarFichaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var valor: UILabel!
    
    public var info:String! {
        didSet {
            self.valor.text = info
            self.setNeedsLayout()
        }
    }
    
}
