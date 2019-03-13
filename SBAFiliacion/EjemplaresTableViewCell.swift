//
//  EjemplaresTableViewCell.swift
//  SBAFiliacion
//
//  Created by Lukas on 26/02/2019.
//  Copyright © 2019 Lucas Avellaneda. All rights reserved.
//

import UIKit

class EjemplaresTableViewCell: UITableViewCell {

    @IBOutlet weak var ejemplarLabel: UILabel!
    @IBOutlet weak var lugarLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var correLabel: UILabel!
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var cuidador: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
