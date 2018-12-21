//
//  TareaTableViewCell.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 20/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class TareaTableViewCell: UITableViewCell {

    @IBOutlet var tituloLabel: UILabel!
    @IBOutlet var descripcionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
