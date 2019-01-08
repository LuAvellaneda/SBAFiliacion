//
//  FormTableViewCell.swift
//  SBAFiliacion
//
//  Created by Lukas on 14/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class FormTableViewCell: UITableViewCell {
    
    var callBack: ((_ id:String,_ val:Bool)->())?

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var controlSwitchOutlet: UISwitch!
    
    @IBAction func controlSwitch(_ sender: UISwitch) {
        
        callBack?(id!,sender.isOn)

    }
    
    var id: String?
    var valor:Bool? {
        didSet {
            controlSwitchOutlet.setOn(valor ?? false, animated: false)
        }
    }
    var titulo: String?  {
        didSet {
            label?.text = titulo
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
