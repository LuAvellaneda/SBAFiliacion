//
//  LugarTableViewCell.swift
//  SBAFiliacion
//
//  Created by Lukas on 26/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class LugarTableViewCell: UITableViewCell {

    @IBOutlet weak var linea1: UILabel!
    @IBOutlet weak var linea2: UILabel!
    @IBOutlet weak var linea3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
