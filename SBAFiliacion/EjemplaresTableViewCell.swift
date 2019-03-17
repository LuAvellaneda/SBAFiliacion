//
//  EjemplaresTableViewCell.swift
//  SBAFiliacion
//
//  Created by Lukas on 26/02/2019.
//  Copyright © 2019 Lucas Avellaneda. All rights reserved.
//

import UIKit

class EjemplaresTableViewCell: UITableViewCell {

    @IBOutlet weak var sexoView: UIView!
    @IBOutlet weak var ejemplarLabel: UILabel!
    @IBOutlet weak var lugarLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var correLabel: UILabel!
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var cuidador: UILabel!
    
    var sexo:String? {
        didSet {
            if(sexo == "M") {
                
                sexoView.backgroundColor = UIColor(red:0.00, green:0.52, blue:1.00, alpha:1.0)
            } else {
                sexoView.backgroundColor  = UIColor(red:1.00, green:0.00, blue:0.96, alpha:1.0)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        estado.text = ""
    }
    
    var estados:[String]? {
        didSet {
            if(estados!.count > 0) {
                estado.text = estados!.joined(separator: " - ")
            }
        }
    }

   
}
